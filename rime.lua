-- rime.lua
-- 增加 KeySequence(string)
-- 1
--    local ks= KeySequence()
--    ks:parse("abc")
-- 2
--    local ks= KeySequence("abc")
--
local _KeySequence=KeySequence
KeySequence = function(str)
  local ks = _KeySequence()
  if type(str)== "string" then
    ks:parse(str)
  end
  return ks
end


--[[
librime-lua 样例

调用方法：
在配方文件中作如下修改：
```
  engine:
    ...
    translators:
      ...
      - lua_translator@lua_function3
      - lua_translator@lua_function4
      ...
    filters:
      ...
      - lua_filter@lua_function1
      - lua_filter@lua_function2
      ...
```

其中各 `lua_function` 为在本文件所定义变量名。
--]]

--[[
本文件的后面是若干个例子，按照由简单到复杂的顺序示例了 librime-lua 的用法。
每个例子都被组织在 `lua` 目录下的单独文件中，打开对应文件可看到实现和注解。

各例可使用 `require` 引入。
如：
```
  foo = require("bar")
```
可认为是载入 `lua/bar.lua` 中的例子，并起名为 `foo`。
配方文件中的引用方法为：`...@foo`。

--]]


-- I. translators:

-- II. filters

show_bopomofo = require("show_bopomofo")

show_quanpin = require("show_quanpin")

