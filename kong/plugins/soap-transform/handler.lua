local kong = kong
local plugin_name = "soap-transform"
local cjson = require "cjson"
local concat = table.concat

local CorrelationIdHandler = {}
CorrelationIdHandler.PRIORITY = 990
CorrelationIdHandler.VERSION = "0.1"

function CorrelationIdHandler:init_worker()

end

function CorrelationIdHandler:body_filter(conf)

  local ctx = ngx.ctx
  local chunk, eof = ngx.arg[1], ngx.arg[2]

  ctx.rt_body_chunks = ctx.rt_body_chunks or {}
  ctx.rt_body_chunk_number = ctx.rt_body_chunk_number or 1

  -- if eof wasn't received keep buffering
  if not eof then
      ctx.rt_body_chunks[ctx.rt_body_chunk_number] = chunk
      ctx.rt_body_chunk_number = ctx.rt_body_chunk_number + 1
      ngx.arg[1] = nil
      return
  end

  -- if bad gateway status recieved return
  if kong.response.get_status() == 502 then
      return nil
  end

  -- last piece of body is ready
  local resp_body = concat(ctx.rt_body_chunks)
  return kong.response.set_raw_body(resp_body)
end

function CorrelationIdHandler:access(conf)
  kong.service.request.enable_buffering()
end

return CorrelationIdHandler
