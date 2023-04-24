local kong = kong
local plugin_name = "soap-transform"
local cjson = require "cjson"
local CorrelationIdHandler = {}

CorrelationIdHandler.PRIORITY = 990
function CorrelationIdHandler:init_worker()
end


function CorrelationIdHandler:access(conf)
  kong.service.request.set_header("Arul", "123")
end

return CorrelationIdHandler
