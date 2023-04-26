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
  local body = kong.response.get_raw_body()
  if body then
    body = "<success>true</success>"
    kong.response.set_raw_body(body) 
  else
    body = "<success>false</success>"
      kong.response.set_raw_body(body)
  end
end 

function CorrelationIdHandler:access(conf)
  kong.service.request.enable_buffering()
end


return CorrelationIdHandler
