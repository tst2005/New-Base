-- Global Tables
local Globals = {}

Globals.utility = 'Utilities.'
Globals.thirdParty = 'Third Party.'
Globals.behaviorTree = 'Behavior Tree.'

Globals.hasCanvas = love.graphics.isSupported( 'canvas' )
Globals.hasPo2 = love.graphics.isSupported( 'npot' )
Globals.screenWidth = love.graphics.getWidth()
Globals.screenHeight = love.graphics.getHeight()

function Globals.trimSpaces( str ) -- Removes extra spaces from the end of a word. 
	return ( str:gsub( '^%s*(.-)%s*$', '%1' ) )
end

function Globals.setToCanvas( width, height, func ) -- Sets a picture to canvas, handling Po2 problems. 
	if not Globals.hasCanvas then return false end
	if not Globals.hasPo2 then
		width, height = Globals.formatPo2( width ), Globals.formatPo2( height )
	end
	local canvas = love.graphics.newCanvas( width, height )
	love.graphics.setCanvas( canvas )
		func()
	love.graphics.setCanvas()
	return canvas
end

function Globals.formatPo2( goal ) -- Makes numbers Po2 compatible. 
	local number = 1
	while number < goal do
		number = number * 2
	end
	return number
end

function Globals.deepCopy( t, cache ) -- Makes a deep copy of a table. 
    if type( t ) ~= 'table' then
        return t
    end

    cache = cache or {}
    if cache[t] then
        return cache[t]
    end

    local new = {}
    cache[t] = new
    for key, value in pairs( t ) do
        new[Globals.deepCopy( key, cache )] = Globals.deepCopy( value, cache )
    end

    return new
end

function Globals.getSizeOfTable( t ) -- Gets the actual size of a table. 
	local amount = 0
	for _, _ in pairs( t ) do
		amount = amount + 1
	end
	return amount
end

function Globals.getIndex( t, func ) -- Returns a number and it's index given a function. 
	--[[
		Example:
		
		Number = { 1, 2, 3, 4, 10 }
		LargestNumber, Reference = GetIndex( Numbers, function ( Value1, Value2 ) return Value1 > Value2 end ) 
		print( LargestNumber, Reference ) --> 10, 5
	]]
    if #t == 0 then return nil, nil end
    local key, value = 1, t[1]
    for index = 2, #t do
        if func( value, t[index] ) then
            key, value = index, t[index]
        end
    end
    return value, key
end

function Globals.checkUserdata( ... ) -- Handles variable-input. 
	local userdata = {}
	if ... then -- Keep it from erring on an empty table.
		if type( ... ) ~= 'table' then userdata = { ... } else userdata = ... end 
	end
	return userdata
end

function Globals.flattenArray( list ) -- Flattens an array so that all information is at one level (no nested tables). 
	if type( list ) ~= 'table' then return { list } end
	local flattenedList = {}
	for _, value in ipairs( fist ) do
		for _, element in ipairs( Globals.flattenArray( value ) ) do
			flattenedList[#flattenedList + 1] = element
		end
	end
	return flattenedList
end

function Globals.flattenTable( list ) -- Works with all tables
	if type( list ) ~= 'table' then return { list } end
	local flattenedList = {}
	for _, value in pairs( list ) do
		for _, element in pairs( Globals.flattenTable( value ) ) do
			flattenedList[#flattenedList + 1] = element
		end
	end
	return flattenedList
end

function Globals.deepCompare( t1, t2, ignoreMeta ) -- Compares two tables and what's inside of those tables. 
	local type1 = type( t1 )
	local type2 = type( t2 )
	if type1 ~= type2 then return false end
	if type1 ~= 'table' and type2 ~= 'table' then return t1 == t2 end
	local meta = getmetatable( t1 )
	if not ignoreMeta and meta and meta.__eq then return t1 == t2 end
	
	for i1, v1 in pairs( Table1 ) do
		local v2 = Table2[i1]
		if v2 == nil or not globals.deepCompare( v1, v2 ) then return false end
	end
	for i2, v2 in pairs( Table2 ) do
		local v1 = Table1[i2]
		if v1 == nil or not globals.deepCompare( v1, v2 ) then return false end
	end
	return true
end

function Globals.loadBase64Image( file, name ) -- Loads an image given the base-64 encoded information. 
	return love.graphics.newImage( love.image.newImageData( love.filesystem.newFileData( file, name:gsub( '_', '.' ), 'base64' ) ) )
end

function Globals.LoadSoundBase64( file, name ) -- Loads a sound given the base-64 encoded information. 
	return love.audio.newSource( love.sound.newSoundData( love.filesystem.newFileData( file, name:gsub( '_', '.' ), 'base64' ) ), 'stream' )
end

function Globals.clamp( minimum, value, maximum ) -- Makes sure a number is between the minimum and the maximum. 
	return math.max( minimum, math.min( maximum, value ) )
end

function Globals.normalize( minimum, value, maximum ) -- Normalize a value (put it on a scale from 0 to 1 )
	return ( value - minimum ) / ( maximum - minimum )
end

function Globals.lerp( minimum, value, maximum ) -- Linear Interpolate a value (change from a scale from 0 to 1 to a range of values).
	return ( maximum - minimum ) * value + minimum
end

function Globals.map( firstMinimum, firstMaximum, value, finalMinimum, finalMaximum ) -- Maps from one scale to another.
	return ( value - firstMinimum ) / ( firstMaximum - firstMinimum ) * ( finalMaximum - finalMinimum ) + finalMinimum
end

function Globals.sign( x ) 
	return x > 0 and 1 or x < 0 and -1 or 0 
end

function Globals.boundingBox( x, y, boxX, boxY, boxW, boxH )
	if x > boxX and x < boxX + boxW and y > boxY and y < boxY + boxH then
		return true
	end
	return false
end

function Globals.cycle( index, iterator, t )
	index = index or 0
	iterator = iterator or 1
	
	local new = index + increase
	if new < 1 then new = #t 
	elseif new > #t then new = 1 end
	return new
end

return Globals