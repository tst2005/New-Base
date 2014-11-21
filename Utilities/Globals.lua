-- Global Tables
local Globals = {}

Globals.Images = {}

Globals.Utility = 'Utilities.'
Globals.ThirdParty = 'Utilities.Third Party.'

Globals.HasCanvas = love.graphics.isSupported( 'canvas' )
Globals.HasPo2 = love.graphics.isSupported( 'npot' )
Globals.ScreenWidth = love.graphics.getWidth()
Globals.SreenHeight = love.graphics.getHeight()

function Globals.TrimSpaces( String ) -- Removes extra spaces from the end of a word. 
	return ( String:gsub( '^%s*(.-)%s*$', '%1' ) )
end

function Globals.SetToCanvas( Width, Height, Function ) -- Sets a picture to canvas, handling Po2 problems. 
	if not Globals.HasCanvas then return false end
	if not Globals.HasPo2 then
		Width, Height = Globals.FormatPo2( Width ), Globals.FormatPo2( Height )
	end
	local Canvas = love.graphics.newCanvas( Width, Height )
	love.graphics.setCanvas( Canvas )
		Function()
	love.graphics.setCanvas()
	return Canvas
end

function Globals.FormatPo2( Goal ) -- Makes numbers Po2 compatible. 
	local Number = 1
	while Goal < Number do
		Number = Number * 2
	end
	return Number
end

function Globals.DeepCopy( Table, Cache ) -- Makes a deep copy of a table. 
    if type( Table ) ~= 'table' then
        return Table
    end

    Cache = Cache or {}
    if Cache[Table] then
        return Cache[Table]
    end

    local New = {}
    Cache[Table] = New
    for Key, Value in pairs( Table ) do
        New[Globals.DeepCopy( Key, Cache)] = Globals.DeepCopy( Value, Cache )
    end

    return New
end

function Globals.GetSizeOfTable( Table ) -- Gets the actual size of a table. 
	local Amount = 0
	for _, _ in pairs( Table ) do
		Amount = Amount + 1
	end
	return Amount
end

function Globals.GetIndex( Table, Function ) -- Returns a number and it's index given a function. 
	--[[
		Example:
		
		Number = { 1, 2, 3, 4, 10 }
		LargestNumber, Reference = GetIndex( Numbers, function ( Value1, Value2 ) return Value1 > Value2 end ) 
		print( LargestNumber, Reference ) --> 10, 5
	]]
    if #Table == 0 then return nil, nil end
    local Key, Value = 1, Table[1]
    for Index = 2, #Table do
        if Function( Value, Table[Index] ) then
            Key, Value = Index, Table[Index]
        end
    end
    return Value, Key
end

function Globals.CheckUserdata( ... ) -- Handles variable-input. 
	local Userdata = {}
	if ... then 
		if type( ... ) ~= 'table' then Userdata = { ... } else Userdata = ... end 
	end
	return Userdata
end

function Globals.FlattenArray( List ) -- Flattens an array so that all information is at one level (no nested tables). 
	if type( List ) ~= 'table' then return { List } end
	local FlattenedList = {}
	for _, Value in ipairs( List ) do
		for _, Element in ipairs( Globals.FlattenArray( Value ) ) do
			FlattenedList[#FlattenedList + 1] = Element
		end
	end
	return FlattenedList
end

function Globals.FlattenTable( List ) -- Works with all tables
	if type( List ) ~= 'table' then return { List } end
	local FlattenedList = {}
	for _, Value in pairs( List ) do
		for _, Element in pairs( Globals.FlattenTable( Value ) ) do
			FlattenedList[#FlattenedList + 1] = Element
		end
	end
	return FlattenedList
end

function Globals.DeepCompare( Table1, Table2, IgnoreMetaTables ) -- Compares two tables and what's inside of those tables. 
	local Type1 = type( Table1 )
	local Type2 = type( Table2 )
	if Type1 ~= Type2 then return false end
	if Type1 ~= 'table' and Type2 ~= 'table' then return Table1 == Table2 end
	local MetaTable = getmetatable( Table1 )
	if not IgnoreMetaTables and MetaTable and MetaTable.__eq then return Table1 == Table2 end
	
	for Index1, Value1 in pairs( Table1 ) do
		local Value2 = Table2[Index1]
		if Value2 == nil or not DeepCompare( Value1, Value2 ) then return false end
	end
	for Index2, Value2 in pairs( Table2 ) do
		local Value1 = Table1[Index2]
		if Value1 == nil or not DeepCompare( Value1, Value2 ) then return false end
	end
	return true
end

function Globals.LoadImageBase64( File, Name ) -- Loads an image given the base-64 encoded information. 
	return love.graphics.newImage( love.image.newImageData( love.filesystem.newFileData( File, Name:gsub( '_', '.' ), 'base64' ) ) )
end

function Globals.LoadSoundBase64( File, Name ) -- Loads a sound given the base-64 encoded information. 
	return love.audio.newSource( love.sound.newSoundData( love.filesystem.newFileData( File, Name:gsub( '_', '.' ), 'base64' ) ), 'stream' )
end

function Globals.Clamp( Minimum, Maximum, Value ) -- Makes sure a number is between the minimum and the maximum. 
	return math.max( Minimum, math.min( Maximum, Value ) )
end

function Globals.Normalize( Minimum, Maximum, Value ) -- Normalize a value (put it on a scale from 0 to 1 )
	return ( Value - Minimum ) / ( Maximum - Minimum )
end

function Globals.Lerp( Minimum, Maximum, Value ) -- Linear Interpolate a value (change from a scale from 0 to 1 to a range of values).
	return ( Maximum - Minimum ) * Value + Minimum
end

function Globals.Map( FirstMinimum, FirstMaximum, Value, FinalMinimum, FinalMaximum ) -- Maps from one scale to another.
	return ( Value - FirstMinimum ) / ( FirstMaximum - FirstMinimum ) * ( FinalMaximum - FinalMinimum ) + FinalMinimum
end

function Globals.Sign( Number ) 
	return Number > 0 and 1 or Number < 0 and -1 or 0 
end

function Globals.BoundingBox( x, y, BoxX, BoxY, BoxW, BoxH )
	if x > BoxX and x < BoxX + BoxW and y > BoxY and y < BoxY + BoxH then
		return true
	end
	return false
end

function Globals.Cycle( Index, Increase, Table )
	Index = Index or 0
	Increase = Increase or 1
	
	local New = Index + Increase
	if New < 1 then New = #Table 
	elseif New > #Table then New = 1 end
	return New
end

return Globals