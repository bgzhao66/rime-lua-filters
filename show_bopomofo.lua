-- Include module bopomofo
local bopomofo = require("bopomofo")

local function filter_func(input, env)
  local ctx = env.engine.context
  local user_input = ctx.input
  local caret = ctx.caret_pos or utf8.len(user_input)

  -- 當前正在輸入的片段（未上屏部分）
  local comp = ctx.composition
  local active_input = user_input
  if comp:empty() == false then
    local seg = comp:back()  -- 最後一個 segment 即當前輸入區
    local start = seg.start
    local endpos = seg._end
    active_input = user_input:sub(start + 1, endpos)
  end

  if not string.match(active_input, "^[A-Za-z]") then
    for cand in input:iter() do
      yield(cand)  -- pass through unmodified (keep preedit)
    end
    return
  end

  for cand in input:iter() do
    local N = utf8.len(cand.text) or 1
    local total_len = math.min(utf8.len(active_input), caret)

    local py_len = math.min(2*N, total_len)
    local py_code = active_input:sub(1, py_len)
    local cj_code = active_input:sub(2*N+1, total_len)

    local zhuyin = bopomofo.shuangpin_to_zhuyin_full(py_code)
    local cj = bopomofo.to_cangjie(cj_code)
    cand.preedit = string.format("%s%s", zhuyin, cj)

    yield(cand)
  end
end

return { func = filter_func }

