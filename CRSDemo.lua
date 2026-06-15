local crs = require("src/CRS")
local bsc = require("basic") -- this is only used for sleep()
local video = {
    {"text", "CRS", 10, 2, "center"},
    {"slp", 1},
    {"text", "-", 10, 2, "right"},
    {"slp", 0.2},
    {"text", "-", 11, 2, "right"},
    {"slp", 0.2},
    {"text", "-", 12, 2, "right"},
    {"slp", 0.5},
    {"text", "Console", 10, 1, "center"},
    {"slp", 0.5},
    {"text", "Rendering", 10, 2, "center"},
    {"slp", 0.5},
    {"text", "System", 10, 3, "center"},
    {"slp", 1},
    {"text", "made by mcoder", 10, 2, "center"},
    {"slp", 1},
    {"text", "and DTier :D", 10, 3, "center"},
    {"slp", 1.5},
    {"smclr", 0.2},
    {"scrs", 22, 6},
    {"slp", 0.1},
    {"scrs", 23, 8},
    {"slp", 0.1},
    {"scrs", 24, 10},
    {"slp", 0.1},
    {"scrs", 25, 11},
    {"slp", 0.5},
    {"text", "Programming language:", 0, 0, "left"},
    {"slp", 1},
    {"cir", 12, 7, 4, "X", "fill"},
    {"cir", 13, 6, 1.5, "-", "fill", 1.6},
    {"cir", 15, 3, 1.5, "X", "fill", 1.7},
    {"slp", 1},
    {"smclr2", 0.1},
    {"slp", 0.5},
    {"text", "Functions:", 0, 0, "left"},
    {"slp", 1},
    {"text", "drawRect()", 12, 2, "center"},
    {"rect", 9, 6, "#", "fill", 6, 4},
    {"slp", 1},
    {"text", "can also be outlined!", 12, 3, "center"},
    {"rect", 9, 6, "-", true, 6, 4},
    {"rect", 9, 6, "#", false, 6, 4},
    {"slp", 1},
    {"smclr", 0.1, 1},
    {"text", "drawCircle()", 12, 2, "center"},
    {"cir", 12, 7, 4, "#", true, 2},
    {"slp", 1},
    {"text", "same thing", 12, 3, "center"},
    {"cir", 12, 7, 4, "-", true, 2},
    {"cir", 12, 7, 4, "#", false, 2},
    {"slp", 1},
    {"smclr2", 0.1},
    {"slp", 1},
    {"text", "For more info check:", 12, 4, "center"},
    {"slp", 1},
    {"text", "the readme.md", 12, 5, "center"},
    {"slp", 1},
    {"text", "it's here for a reason", 12, 6, "center"},
    {"slp", 1},
    {"smclr2", 0.1}
}
crs.setScreenSize(21, 5, 1)
crs.setBG("-")
for _,v in ipairs(video) do
    if v[1] == "text" then
        crs.drawText(v[2], v[3], v[4], v[5])
        crs.ps()
    elseif v[1] == "slp" then
        bsc.sleep(v[2])
    elseif v[1] == "clr" then
        crs.cleanScr()
        crs.ps()
    elseif v[1] == "cir" then
        crs.drawCircle(v[2], v[3], v[4], v[5], v[6], v[7])
        crs.ps()
    elseif v[1] == "scrs" then
        crs.setScreenSize(v[2], v[3], v[4])
        if not v[5] then crs.ps() end
    elseif v[1] == "smclr" then
        -- mcoder your way of making abbreviations is stupid af like i thought scrs meant scars :P
        -- don't even dare to start another argument i will block you
        -- come on you have no friends exept for me you wouldn't do that :3
        local kill = ""
        for _ = 1, crs.getScreenSize().width do kill = kill .. crs.getBG() end
        local ii = 0
        if v[3] then ii = v[3] end
        for i = ii, crs.getScreenSize().height do
            crs.drawText(kill, 0, i, "left")
            crs.ps()
            bsc.sleep(v[2])
        end
    elseif v[1] == "rect" then
        crs.drawRect(v[2], v[3], v[4], v[5], v[6], v[7])
        crs.ps()
    elseif v[1] == "smclr2" then
        local pixels = {}
        local width = crs.getScreenSize().width
        local height = crs.getScreenSize().height
        local bg = crs.getBG()
        for y = 0, height do
            for x = 0, width do
                if crs.getSymbolAt(x, y) ~= bg then
                    table.insert(pixels, {x = x, y = y})
                end
            end
        end
        while #pixels > 0 do
            local batch_size = math.max(5, math.floor(#pixels * 0.10))
            if batch_size > #pixels then batch_size = #pixels end
            for _ = 1, batch_size do
                local index = math.random(1, #pixels)
                local target = table.remove(pixels, index)
                crs.drawSymbol(bg, target.x, target.y)
            end
            crs.ps()
            bsc.sleep(v[2])
        end
    end
end
