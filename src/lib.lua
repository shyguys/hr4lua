local lib = {}

function lib.print_paragrpah(length, outer, inner, title)
   local begins = "BEGIN"
   local ends = "END"
   if title then
      begins = begins .. " " .. title
      ends = ends .. " " .. title
   end
   lib.print_titled(length, outer, inner, begins)
   lib.print_titled(length, outer, inner, ends)
end

function lib.print_titled(length, outer, inner, title)
   local spare_len = length - #outer * 2 - #title - 4
   if spare_len < 2 then
      io.stderr:write("Length insufficient, " .. tostring(2 - spare_len) .. " more required.\n")
      os.exit(1)
   end
   local rspare_len = spare_len // 2
   local lspare_len = spare_len - rspare_len
   io.write(string.format("%s %s %s %s %s\n", outer, string.rep(inner, lspare_len), title,
      string.rep(inner, rspare_len), outer))
end

function lib.print_untitled(length, outer, inner)
   local spare_len = length - #outer * 2 - 2
   if spare_len < 1 then
      io.stderr:write("Length insufficient, " .. tostring(1 - spare_len) .. " more required.\n")
      os.exit(1)
   end
   io.write(string.format("%s %s %s\n", outer, string.rep(inner, spare_len), outer))
end

return lib
