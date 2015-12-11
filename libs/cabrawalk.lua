--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:cc0a56378c16b56f034ec095397e4c4e:5f39c0562913a4f15ec1922188c38bf2:4470d6c59dc3373334dbf6d18f545509$
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
            width=181,
            height=230,

            sourceX = 92,
            sourceY = 62,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00001
            x=216,
            y=225,
            width=198,
            height=212,

            sourceX = 77,
            sourceY = 45,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00002
            x=416,
            y=209,
            width=235,
            height=173,

            sourceX = 64,
            sourceY = 53,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00003
            x=379,
            y=1,
            width=185,
            height=206,

            sourceX = 91,
            sourceY = 41,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00004
            x=1,
            y=233,
            width=213,
            height=209,

            sourceX = 87,
            sourceY = 83,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00005
            x=184,
            y=1,
            width=193,
            height=222,

            sourceX = 89,
            sourceY = 66,
            sourceWidth = 350,
            sourceHeight = 350
        },
        {
            -- Walk_00006
            x=566,
            y=1,
            width=194,
            height=192,

            sourceX = 77,
            sourceY = 102,
            sourceWidth = 350,
            sourceHeight = 350
        },
    },
    
    sheetContentWidth = 761,
    sheetContentHeight = 443
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

SheetInfo.sequenceData = 
{
    {name="walk",start=1,count=7,time=700,},
    {name="jump",frames={7,1,2,3},time=500,loopCount=1},
    {name="fall",frames={3,4,5,6},time=500,loopCount=1},
    {name="freefall",start=2,count=3,time=300,loopCount=4},
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

