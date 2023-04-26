local kong = kong
local plugin_name = "soap-transform"
local cjson = require "cjson"

local CorrelationIdHandler = {}
CorrelationIdHandler.PRIORITY = 990
CorrelationIdHandler.VERSION = "0.1"

function CorrelationIdHandler:init_worker()

end

function CorrelationIdHandler:body_filter(conf)

  local body = kong.response.get_raw_body()
  body = body:gsub("John", "Arul")
  return kong.response.set_raw_body("<root>false</root>")
end

function CorrelationIdHandler:access(conf)
  kong.service.request.enable_buffering()
end

return CorrelationIdHandler
