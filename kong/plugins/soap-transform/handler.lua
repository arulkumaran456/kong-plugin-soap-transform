local kong = kong
local plugin_name = "soap-transform"
local cjson = require "cjson"
local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")

local CorrelationIdHandler = {}
local xml2json = {}

CorrelationIdHandler.PRIORITY = 990
CorrelationIdHandler.VERSION = "0.1"

function CorrelationIdHandler:init_worker()
end

function CorrelationIdHandler:body_filter(config)
 
end 

function CorrelationIdHandler:access(conf)
  --local json_body = xml2json.test(body)
  kong.response.set_header("Arulkumar", "123")
  kong.response.set_header("content-type", "application/xml; charset=utf-8")


local xml = [[
<people>
  <person type="natural">
    <name>Manoel</name>
    <city>Palmas-TO</city>
  </person>
  <person type="legal">
    <name>University of Brasília</name>
    <city>Brasília-DF</city>
  </person>
</people>
]]

--Instantiates the XML parser
local parser = xml2lua.parser(handler)
parser:parse(xml)
local xml = handler.root
local json_text = cjson.encode(xml)
kong.response.set_header("Surya", json_text)
end


return CorrelationIdHandler
