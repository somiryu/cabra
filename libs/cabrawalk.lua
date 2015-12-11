--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:cf09b70e678982458a9a2ce77b35a6ae:6f6752977c8b9529f60f16978a216228:4470d6c59dc3373334dbf6d18f545509$
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
            y=444,
            width=181,
            height=230,

            sourceX = 92,
            sourceY = 62,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00001
            x=1,
            y=676,
            width=198,
            height=212,

            sourceX = 77,
            sourceY = 45,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00002
            x=424,
            y=1,
            width=235,
            height=173,

            sourceX = 64,
            sourceY = 53,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00003
            x=201,
            y=675,
            width=185,
            height=206,

            sourceX = 91,
            sourceY = 41,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00004
            x=209,
            y=1,
            width=213,
            height=209,

            sourceX = 87,
            sourceY = 83,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00005
            x=1,
            y=220,
            width=193,
            height=222,

            sourceX = 89,
            sourceY = 66,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00006
            x=480,
            y=382,
            width=194,
            height=192,

            sourceX = 77,
            sourceY = 102,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_hit_wall_00000
            x=472,
            y=176,
            width=185,
            height=204,

            sourceX = 91,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_hit_wall_00001
            x=184,
            y=444,
            width=161,
            height=229,

            sourceX = 102,
            sourceY = 54,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_hit_wall_00002
            x=388,
            y=660,
            width=96,
            height=258,

            sourceX = 163,
            sourceY = 54,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_hit_wall_00003
            x=1,
            y=1,
            width=206,
            height=217,

            sourceX = 31,
            sourceY = 92,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_hit_wall_00004
            x=1,
            y=890,
            width=252,
            height=117,

            sourceX = 1,
            sourceY = 158,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_standby_00000
            x=196,
            y=220,
            width=139,
            height=222,

            sourceX = 111,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_standby_00001
            x=337,
            y=212,
            width=133,
            height=222,

            sourceX = 111,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_standby_00002
            x=347,
            y=436,
            width=131,
            height=222,

            sourceX = 107,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_standby_00003
            x=486,
            y=576,
            width=127,
            height=222,

            sourceX = 111,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_standby_00004
            x=615,
            y=576,
            width=127,
            height=222,

            sourceX = 111,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- llama_standby_00005
            x=486,
            y=800,
            width=127,
            height=222,

            sourceX = 111,
            sourceY = 63,
            sourceWidth = 350,
            sourceHeight = 350
        },
    },
    
    sheetContentWidth = 743,
    sheetContentHeight = 1023
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
    ["llama_hit_wall_00000"] = 8,
    ["llama_hit_wall_00001"] = 9,
    ["llama_hit_wall_00002"] = 10,
    ["llama_hit_wall_00003"] = 11,
    ["llama_hit_wall_00004"] = 12,
    ["llama_standby_00000"] = 13,
    ["llama_standby_00001"] = 14,
    ["llama_standby_00002"] = 15,
    ["llama_standby_00003"] = 16,
    ["llama_standby_00004"] = 17,
    ["llama_standby_00005"] = 18,
}

SheetInfo.sequenceData = 
{
    {name="walk",start=1,count=7,time=700,},
    {name="jump",frames={7,1,2,3},time=500,loopCount=1},
    {name="fall",frames={3,4,5,6},time=500,loopCount=1},
    {name="freefall",start=2,count=3,time=300,loopCount=0},
    {name="hitwall",start=8,count=5,time=500,loopCount=1},
    {name="standby",start=13,count=6,time=1000,loopCount=0},

}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

function SheetInfo:getSequenceData()
    return self.sequenceData;
end

return SheetInfo
