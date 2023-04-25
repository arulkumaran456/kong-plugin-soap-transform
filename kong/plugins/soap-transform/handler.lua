local kong = kong
local plugin_name = "soap-transform"
local cjson = require "cjson"
local CorrelationIdHandler = {}
local xml2json = {}

CorrelationIdHandler.PRIORITY = 990
CorrelationIdHandler.VERSION = "0.1"

function CorrelationIdHandler:init_worker()
end

function CorrelationIdHandler:body_filter(config)
    
end 

function CorrelationIdHandler:access(conf)
  local body = kong.response.get_raw_body()
  local json_body = xml2json.test(body)
  kong.response.set_header("Arulkumar", json_body)
  kong.response.set_header("content-type", "application/xml; charset=utf-8")
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function table.map_length(t)
    local c = 0
    for k,v in pairs(t) do
         c = c+1
    end
    return c
end

local function parseargs(s)
  local arg = {}
  string.gsub(s, "([%-%w]+)=([\"'])(.-)%2", function (w, _, a)
    arg[w] = a
  end)
  return arg
end

function xml2json.collect(s)
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni,c,label,xarg, empty
  local i, j = 1, 1
  while true do
    ni,j,c,label,xarg, empty = string.find(s, "<(%/?)([%w:]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(s, i, ni-1)
    if not string.find(text, "^%s*$") then
      top[label] =  text
    end
    if empty == "/" then  -- empty element tag
      local key = ""
      for k,v in pairs(top) do key = k; break end
      top[key][label] = ""
    elseif c == "" then   -- start tag
        top = { [label] = "" }
        table.insert(stack, top)
    else  -- end tag
       local toclose = table.remove(stack)
       top = stack[#stack]
      if #stack < 1 then
       -- error("nothing to close with "..label)
      end
      local key = ""
      for k,v in pairs(toclose) do key = k; break end

      if key ~= label then
        --error("trying to close "..key.." with "..label)
      end


      key = ""
      for k,v in pairs(top) do key = k; break end
      if top[key] == nil or (top[key] and top[key] == "") then
        top[key] = toclose
      else -- append
        for k,v in pairs(toclose) do
          top[key][k] = v
        end
      end
    end
    i = j+1
  end

  for k,v in pairs(stack[1]) do
    return v
  end

end
function xml2json.test(resp_body)
  local xml_string = resp_body
  local output = xml2json.collect(xml_string)
  return cjson.encode(output)
end

return CorrelationIdHandler
