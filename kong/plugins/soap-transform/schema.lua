local typedefs = require "kong.db.schema.typedefs"


local PLUGIN_NAME = "soap-transform"


local schema = {
  name = PLUGIN_NAME,
  fields = {
    -- the 'fields' array is the top-level entry with fields defined by Kong
    { consumer = typedefs.no_consumer },  -- this plugin cannot be configured on a consumer (typical for auth plugins)
    { protocols = typedefs.protocols_http },
    { config = {
        -- The 'config' record is the custom part of the plugin schema
        type = "record",
        fields = {
          -- a standard defined field (typedef), with some customizations
          { request_header = typedefs.header_name {
              required = false,
              default = "Arulkumar" } },  
           { ignore_content_type = typedefs.header_name {
              required = false,
              default = "json" } },
        },
        entity_checks = {
          -- We specify that both header-names cannot be the same
          { distinct = { "request_header", "ignore_content_type"} },
        },
      },
    },
  },
}

return schema