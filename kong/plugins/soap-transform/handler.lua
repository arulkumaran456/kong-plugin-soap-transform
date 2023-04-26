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
  local ctx = ngx.ctx
  if ctx.buffers == nil then
      ctx.buffers = {}
      ctx.nbuffers = 0
  end

  -- Load response body
  local data = ngx.arg[1]
  local eof = ngx.arg[2]
  local next_idx = ctx.nbuffers + 1

  if not eof then
      if data then
          ctx.buffers[next_idx] = data
          ctx.nbuffers = next_idx
          ngx.arg[1] = nil
      end
      return
  elseif data then
      ctx.buffers[next_idx] = data
      ctx.nbuffers = next_idx
  end

  kong.response.set_header("Surya", data)
end 

function CorrelationIdHandler:access(conf)
  --local json_body = xml2json.test(body)
  kong.response.set_header("Arulkumar", "123")
  kong.response.set_header("content-type", "application/xml; charset=utf-8")

  
end


return CorrelationIdHandler