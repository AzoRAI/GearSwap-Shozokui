fixed_pos = ''
fixed_ts = os.time()

windower.raw_register_event('outgoing chunk',function(id,original,modified,injected,blocked)
    if not blocked then
        if id == 0x15 then
            if (gearswap.cued_packet or midaction()) and fixed_pos ~= '' and os.clock() < holdMovement then
                return original:sub(1,4)..fixed_pos..original:sub(17)
            else
                fixed_pos = original:sub(5,16)
                fixed_ts = os.time()
            end
        end
    end
end)