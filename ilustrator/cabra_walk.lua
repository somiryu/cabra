--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c5489b9cfc5246ec3591f5010326e68b:5f39c0562913a4f15ec1922188c38bf2:eb13d660713af33e33e6cd8eacdcc668$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- Walk_00000
            x=1,
            y=1,
            width=360,
            height=460,

            sourceX = 185,
            sourceY = 124,
            sourceWidth = 700,
            sourceHeight = 700
        },
        {
            -- Walk_00001
            x=427,
            y=447,
            width=394,
            height=424,

            sourceX = 155,
            sourceY = 90,
            sourceWidth = 700,
            sourceHeight = 700
        },
        {
            -- Walk_00002
            x=823,
            y=415,
            width=468,
            height=344,

            sourceX = 129,
            sourceY = 107,
            sourceWidth = 700,
            sourceHeight = 700
        },
        {
            -- Walk_00003
            x=751,
            y=1,
            width=368,
            height=412,

            sourceX = 183,
            sourceY = 82,
            sourceWidth = 700,
            sourceHeight = 700
        },
        {
            -- Walk_00004
            x=1,
            y=463,
            width=424,
            height=416,

            sourceX = 175,
            sourceY = 167,
            sourceWidth = 700,
            sourceHeight = 700
        },
        {
            -- Walk_00005
            x=363,
            y=1,
            width=386,
            height=444,

            sourceX = 178,
            sourceY = 132,
            sourceWidth = 700,
            sourceHeight = 700
        },
        {
            -- Walk_00006
            x=1121,
            y=1,
            width=386,
            height=384,

            sourceX = 155,
            sourceY = 204,
            sourceWidth = 700,
            sourceHeight = 700
        },
    },
    
    sheetContentWidth = 1508,
    sheetContentHeight = 880
}

SheetInfo.frameIndex =
{

    ["Walk_00000"] = 1,
    ["Walk_00001"] = 2,
    ["Walk_00002"] = 3,
    ["Walk_00003"] = 4,
    ["Walk_00004"] = 5,
    ["Walk_00005"] = 6,
    ["Walk_00006"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
