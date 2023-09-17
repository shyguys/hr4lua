#!/usr/bin/env lua

local lib = require("lib")

local PROG = "hr4lua"

local function usage()
   io.write([[
usage: ]] .. PROG .. [[ [-h] [-l INT] [-o STR] [-i CHAR] [-p] [title]

positional arguments:
  title               title to insert in center

options:
  -h, --help          show this help message and exit
  -l, --length INT    total character length (default: 80)
  -o, --outer STR     outer character(s) (default: --)
  -i, --inner CHAR    inner character (default: -)
  -p, --as-paragraph  as paragraph, BEGIN and END
]])
end

local function parse_args()
   local args = {
      length = 80,
      outer = "--",
      inner = "-",
      as_paragraph = false,
      title = nil
   }

   local opt
   local optarg
   local i = 1
   while arg[i] do
      opt = arg[i]
      if opt == "-h" or opt == "--help" then
         usage()
         os.exit()
      elseif opt == "-l" or opt == "--length" then
         i = i + 1
         optarg = arg[i]
         if not optarg then
            io.stderr:write(PROG .. ": -l/--length expected one argument\n")
            os.exit(1)
         end
         optarg = tonumber(optarg)
         if not optarg then
            io.stderr:write(PROG .. ": -l/--length must be an integer\n")
            os.exit(1)
         end
         args.length = optarg
      elseif opt == "-o" or opt == "--outer" then
         i = i + 1
         optarg = arg[i]
         if not optarg then
            io.stderr:write(PROG .. ": -o/--outer expected one argument\n")
            os.exit(1)
         end
         args.outer = optarg
      elseif opt == "-i" or opt == "--inner" then
         i = i + 1
         optarg = arg[i]
         if not optarg then
            io.stderr:write(PROG .. ": -i/--inner expected one argument\n")
            os.exit(1)
         end
         args.outer = string.sub(opt, 1, 1)
      elseif opt == "-p" or opt == "--as-paragraph" then
         args.as_paragraph = true
      elseif string.sub(opt, 1, 1) == "-" then
         io.stderr:write(PROG .. ": option '" .. opt .. "' not recognized\n")
         os.exit(1)
      else
         if not args.title then
            args.title = opt
         else
            io.stderr:write(PROG .. ": positional argument '" .. opt .. "' not recognized\n")
            os.exit(1)
         end
      end
      i = i + 1
   end

   return args
end

local function main()
   args = parse_args()
   if args.as_paragraph then
      lib.print_paragrpah(args.length, args.outer, args.inner, args.title)
   elseif args.title then
      lib.print_titled(args.length, args.outer, args.inner, args.title)
   else
      lib.print_untitled(args.length, args.outer, args.inner)
   end
end

main()
