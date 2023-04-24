local plugin_name = "soap-transform"
local cjson = require "cjson"

local plugin = {
  PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
  VERSION = "0.1", -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.
}

local xml_json_transformer = require("kong.plugins.base_plugin"):extend()

-- constructor
function xml_json_transformer:new()
  xml_json_transformer.super.new(self, plugin_name)
end

function plugin:access(plugin_conf)
  kong.log.inspect(plugin_conf)   -- check the logs for a pretty-printed config!
  kong.service.request.set_header(plugin_conf.request_header, "this is on a request")

end

function plugin:header_filter(plugin_conf)
  kong.response.set_header(plugin_conf.response_header, "this is on the response")
end

return xml_json_transformer
