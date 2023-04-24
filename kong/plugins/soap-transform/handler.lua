local plugin_name = "soap-transform"
local cjson = require "cjson"

local xml_json_transformer = require("kong.plugins.base_plugin"):extend()

-- constructor
function xml_json_transformer:new()
  xml_json_transformer.super.new(self, plugin_name)
end

function xml_json_transformer:access(plugin_conf)
  kong.log.inspect(plugin_conf)   -- check the logs for a pretty-printed config!
  kong.service.request.set_header(plugin_conf.request_header, "this is on a request")

end

function xml_json_transformer:header_filter(plugin_conf)
  kong.response.set_header(plugin_conf.response_header, "this is on the response")
end

xml_json_transformer.PRIORITY = 990

return xml_json_transformer
