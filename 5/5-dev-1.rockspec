package = "5"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/rfaulhaber/aoc-2023.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
           main = "main.lua",
           solve = "solve.lua"
   }
}
