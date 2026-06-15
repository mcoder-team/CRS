-- 1.0B
local crs = {} -- function set
local scr = {} -- screen
local filler = "-"
local scrS = {width = 40, height = 15}

local function utf8char(str, pos)
    local byte_pos = utf8.offset(str, pos)
    if not byte_pos then return nil end
    local next_byte = utf8.offset(str, pos + 1)
    return str:sub(byte_pos, next_byte and (next_byte - 1) or #str)
end

function crs.setScreen(tabl)
    scr = tabl
end

function crs.cleanScr()
    scr = {}
    for i = 1, scrS.height * scrS.width do
        scr[i] = filler
    end
end

crs.cleanScr()

function crs.setBG(s, clr)
    filler = s
    if not clr then crs.cleanScr() end
end

function crs.getSymbolAt(x, y, return_index)
    local index = x + (y * scrS.width) + 1
    if return_index then
        return index
    end
    return scr[index]
end

function crs.setScreenSize(w, h, clr)
    scrS.width = w or scrS.width
    scrS.height = h or scrS.height
    if not clr then crs.cleanScr() end
end

function crs.getScreenSize()
    return scrS
end

function crs.getScreen()
    local rows = {}
    for i = 0, scrS.height - 1 do
        local row = {}
        for j = 0, scrS.width - 1 do
            table.insert(row, crs.getSymbolAt(j, i))
        end
        table.insert(rows, table.concat(row))
    end
    return table.concat(rows, "\n")
end

function crs.getScreen_TABLE()
    return scr
end

function crs.getBG()
    return filler
end

function crs.drawSymbol(s, x, y)
    if x < 0 or x >= scrS.width or y < 0 or y >= scrS.height then
        return nil
    end
    local idx = crs.getSymbolAt(x, y, true)
    if idx >= 1 and idx <= #scr then
        scr[idx] = s
    end
    return scr[idx]
end

function crs.drawRect(x, y, symbol, fill, w, h)
    for i = y, y + h - 1 do
        for j = x, x + w - 1 do
            if fill then
                crs.drawSymbol(symbol, j, i)
            else
                if i == y or i == y + h - 1 or j == x or j == x + w - 1 then
                    crs.drawSymbol(symbol, j, i)
                end
            end
        end
    end
end

function crs.drawCircle(x0, y0, r, symbol, fill, asp, thick)
    local aspect = asp or 1.8
    local start_x = math.max(0, math.floor(x0 - r))
    local end_x = math.min(scrS.width - 1, math.ceil(x0 + r))
    local start_y = math.max(0, math.floor(y0 - r / aspect))
    local end_y = math.min(scrS.height - 1, math.ceil(y0 + r / aspect))
    local thickness = thick or 0.5
    for i = start_y, end_y do
        for j = start_x, end_x do
            local dx = j - x0
            local dy = (i - y0) * aspect
            local distance = math.sqrt(dx^2 + dy^2)
            if fill then
                if distance <= r + 0.5 then
                    crs.drawSymbol(symbol, j, i)
                end
            else
                if distance >= (r - thickness) and distance <= (r + thickness) then
                    crs.drawSymbol(symbol, j, i)
                end
            end
        end
    end
end

function crs.drawText(txt, x, y, align)
    local alignment = align or "left"
    local len = utf8.len(txt)
    if not len then return end
    local start_x = x
    if alignment == "center" then
        start_x = x - math.floor(len / 2)
    elseif alignment == "right" then
        start_x = x - len
    elseif alignment ~= "left" then
        error("drawText: wrong alignment -> " .. tostring(alignment))
    end
    for i = 1, len do
        local char = utf8char(txt, i)
        if char then
            crs.drawSymbol(char, start_x + (i - 1), y)
        end
    end
end

function crs.ps()
    print("\27[2J\27[H")
    for i = 0, scrS.height - 1 do
        local row = {}
        for j = 0, scrS.width - 1 do
            table.insert(row, crs.getSymbolAt(j, i))
        end
        print(table.concat(row))
    end
end

return crs