-- Include module bopomofo
local bopomofo = require("bopomofo")

local function filter_func(input, env)
  local ctx = env.engine.context
  local user_input = ctx.input
  local caret = ctx.caret_pos or utf8.len(user_input)

  if not string.match(user_input, "^[A-Za-z]") then
    for cand in input:iter() do
      yield(cand)  -- pass through unmodified (keep preedit)
    end
    return
  end

  for cand in input:iter() do
    local N = utf8.len(cand.text) or 1
    local total_len = math.min(utf8.len(user_input), caret)
    local py_len = math.min(2*N, total_len)
    local py_code = user_input:sub(1, py_len)
    local cj_code = user_input:sub(2*N+1, total_len)

    local quanpin = bopomofo.shuangpin_to_quanpin_full(py_code)
    cand.preedit = string.format("%s%s", quanpin, cj_code)

    yield(cand)
  end
end

return { func = filter_func }

