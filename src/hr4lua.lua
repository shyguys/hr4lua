#!/usr/bin/env lua

local argparse = require("argparse")
local lib = require("hr4lua.lib")

local PROG = "hr4lua"

local function parse_args()
   local parser = argparse()
       :name(PROG)
       :help_description_margin(23)
   parser:argument()
       :name("title")
       :argname("title")
       :description("Title to insert in center.")
       :args("?")
   parser:flag()
       :name("-p"):name("--as-paragraph")
       :description("Print two horizontal rules, BEGIN and END.")
   parser:group("Style properties",
      parser:option()
      :name("-i"):name("--inner")
      :argname("STR")
      :description("Inner character (default: -).")
      :show_default(false)
      :default("-")
      :action(function(namespace, index, arg)
         namespace[index] = string.sub(string.gsub(arg, "^%s*(.-)%s*$", "%1"), 1, 1)
      end),
      parser:option()
      :name("-l"):name("--length")
      :argname("INT")
      :description("Total character length (default: 80).")
      :show_default(false)
      :convert(tonumber)
      :default(80),
      parser:option()
      :name("-o"):name("--outer")
      :argname("STR")
      :description("Outer character(s) (default: --).")
      :show_default(false)
      :default("--")
      :action(function(namespace, index, arg)
         namespace[index] = string.gsub(arg, "^%s*(.-)%s*$", "%1")
      end)
   )
   return parser:parse()
end

local function main()
   local args = parse_args()
   local ok, err
   if args.as_paragraph then
      ok, err = pcall(lib.print_as_paragrpah, args.length, args.outer, args.inner, args.title)
   elseif args.title then
      ok, err = pcall(lib.print_titled, args.length, args.outer, args.inner, args.title)
   else
      ok, err = pcall(lib.print_untitled, args.length, args.outer, args.inner)
   end
   if not ok then
      io.stderr:write("[ERROR] " .. err .. "\n")
      os.exit(1)
   end
end

main()
