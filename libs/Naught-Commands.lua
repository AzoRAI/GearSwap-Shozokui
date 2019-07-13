function init_include()


  rotations = {}
  rotations.ambu_turtle = chain_commands(
    build_command("blade-madrigal"),
    build_command("ice-carol"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("water-carol")
  )

  rotations.two_min_march = chain_commands(
    build_command("valor-minuet-v"),
    build_command("valor-minuet-iv"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("victory-march")
  )
  rotations.two_min_mad = chain_commands(
    build_command("valor-minuet-v"),
    build_command("valor-minuet-iv"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("blade-madrigal")
  )

  rotations.min_two_mad = chain_commands(
    build_command("valor-minuet-v"),
    build_command("blade-madrigal"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("sword-madrigal")
  )

  rotations.march_two_mad = chain_commands(
    build_command("victory-march"),
    build_command("blade-madrigal"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("sword-madrigal")
  )

  rotations.scherzo_two_mad = chain_commands(
    build_command("sentinels-scherzo"),
    build_command("sword-madrigal"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("blade-madrigal")
  )

  rotations.scherzo_min_mad = chain_commands(
    build_command("sentinels-scherzo"),
    build_command("valor-minuet-v"),
    build_command("armys-paeon"),
    build_command("gold-capriccio"),
    build_command("blade-madrigal")
  )

end

function rotation_for(target, use_buffs)
  -- TODO: Handle this
end

function songs_for(target)
  -- TODO: Return song commands for target
end

function table.slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end

function chain_commands(...)
  local pieces = table.slice(arg, 1, table.getn(arg))
  return table.concat(pieces, " ");
end

function nitro(chain)
  chain = string.gsub(chain, "wait 5;", "wait 3.5;")
  return chain_commands(
    build_command("nightingale", nil, 1),
    build_command("troubadour", nil, 3.5),
    chain
  )
end

-- function handle_buff_rotation_request(name)
--   local rotation = bard_buff_rotations[name]
--   if rotation then
--     add_to_chat(158, "Buff Rotation: "..name)
--     send_command(rotation)
--   end
-- end

function build_command(name, target, wait)
  target = target or "me"
  wait = wait or 5
  return name.." "..target.."; wait "..wait..";"
end


function build_command_string(type, name, target, duration)
  return "input /"..type.." \""..name.."\" <"..target..">; wait "..duration..";";
end

function build_shortcut_string(name, target, duration)
  return "input /"..name.." "..target
end


init_include()
