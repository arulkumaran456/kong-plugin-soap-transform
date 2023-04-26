local kong = kong
local plugin_name = "soap-transform"
local cjson = require "cjson"

local CorrelationIdHandler = {}
local xml2json = {}

CorrelationIdHandler.PRIORITY = 990
CorrelationIdHandler.VERSION = "0.1"

function CorrelationIdHandler:init_worker()
end

function CorrelationIdHandler:access(conf)

  kong.service.request.enable_buffering()
end

function CorrelationIdHandler:response(conf)
  kong.service.response.get_body()
  kong.service.response.get_raw_body()

end


return CorrelationIdHandler
