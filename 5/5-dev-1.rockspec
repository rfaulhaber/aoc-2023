package = "5"
version = "dev-1"
rockspec_format = "3.0"
source = {
   url = "git+ssh://git@github.com/rfaulhaber/aoc-2023.git"
}
description = {
   homepage = "https://github.com/rfaulhaber/aoc-2023",
   license = "GNU GPL-3.0"
}
dependencies = {
  "lua >= 5.1"
}
test_dependencies = {
    "luaunit >= 3.4-1"
}
build = {
   type = "builtin",
   modules = {
           main = "main.lua",
           solve = "solve.lua",
           range = "range.lua"
   }
}
test = {
    type = "command",
    script = "range.test.lua"
}
