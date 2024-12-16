local typedefs = require "kong.db.schema.typedefs"

local PLUGIN_NAME = "add-date-in-response"

local schema = {
 name = PLUGIN_NAME,
 fields = {
   { consumer = typedefs.no_consumer },
   { protocols = typedefs.protocols_http },    
   { config = {
       type = "record",
       fields = {
         { response_header_name = typedefs.header_name {
           required = true,
           default = "X-My-Date" } },
       },
     },
   },
 },
}

return schema
