local typedefs = require "kong.db.schema.typedefs"
local PLUGIN_NAME = "soap-transform"
local schema = {
  name = PLUGIN_NAME,
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { ignore_content_type = typedefs.header_name {
              required = false,
              type = "boolean",
              default = false } },
        },
        entity_checks = { 
        },
      },
    },
  },
}
return schema
