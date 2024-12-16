local PluginHandler = {
 PRIORITY = 1000,
 VERSION = "0.0.1",
}

function PluginHandler:response(conf)

  kong.response.set_header( conf.response_header_name, os.date("%A %c"))
 
end

return PluginHandler
