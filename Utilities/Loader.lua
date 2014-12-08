local loveloader = require 'Utilities.Third Party.love-loader'
return { 
	newImage = function( t, name, path )
		loveloader.newImage( t, name, path )
	end, 
	newFont = function( t, name, path, Size )
		loveloader.newFont( t, name, path, Size )
	end, 
	newSource = function( t, name, path, type )
		loveloader.newSource( t, name, path, type )
	end, 
	newSoundData = function( t, name, pathOrDecoder )
		loveloader.newSoundData( t, name, pathOrDecoder )
	end, 
	newImageData = function( t, key, path )
		loveloader.newImageData( t, key, path )
	end, 
	start = function( onComplete, onLoad )
		loveloader.start( onComplete, onLoad )
		-- onLoad( type <String>, Holder <t>, key <String> )
	end, 
	update = function() return loveloader.update() end
}