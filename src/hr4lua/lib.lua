local lib = {}

function lib.print_as_paragrpah(length, outer, inner, title)
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
   local spare_length = length - #outer * 2 - #title - 4
   if spare_length < 2 then
      error("length insufficient, " .. tostring(2 - spare_length) .. " more required", 0)
   end
   local right_spare_length = spare_length // 2
   local left_spare_length = spare_length - right_spare_length
   io.write(string.format(
      "%s %s %s %s %s\n",
      outer,
      string.rep(inner, left_spare_length),
      title,
      string.rep(inner, right_spare_length),
      outer
   ))
end

function lib.print_untitled(length, outer, inner)
   local spare_length = length - #outer * 2 - 2
   if spare_length < 1 then
      error("length insufficient, " .. tostring(1 - spare_length) .. " more required", 0)
   end
   io.write(string.format("%s %s %s\n", outer, string.rep(inner, spare_length), outer))
end

return lib
