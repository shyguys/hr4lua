package = "hr4lua"
version = "1.1-1"
source = {
   url = "https://github.com/shyguys/hr4lua",
   tag = "v1.1.0"
}
description = {
   summary = "Prints horizontal rules.",
   homepage = "https://github.com/shyguys/hr4lua",
   license = "MIT"
}
dependencies = {"lua >= 5.4"}
build = {
   type = "builtin",
   modules = {
      hr4lua = "src/hr4lua.lua",
      lib = "src/lib.lua"
   }
}
