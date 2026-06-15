local basic = {}

function basic.printRecursive(table, t)
    for _,v in ipairs(table) do
        if type(v) == "table" then
            basic.printRecursive(v, t + 1)
        else
            local txt = v
            if t then
                for _ = 1, t do
                    txt = "\t" .. txt
                end
            end
            print(v)
        end
    end
end

function basic.factorial(n)
    if n < 0 then return nil end
    if n == 0 then return 1 end
    return n * basic.factorial(n - 1)
end

function basic.sleep(sec)
    local slp = os.clock() + sec
    while os.clock() < slp do end
end

function basic.utf8char(str, pos)
    local byte_pos = utf8.offset(str, pos)
    if not byte_pos then return nil end
    return str:sub(byte_pos, utf8.offset(str, pos + 1) - 1)
end

return basic