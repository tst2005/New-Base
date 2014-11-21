local loveloader = require 'Utilities.Third Party.love-loader'
return { 
	NewImage = function( Table, Name, Path )
		loveloader.newImage( Table, Name, Path )
	end, 
	NewFont = function( Table, Name, Path, Size )
		loveloader.newFont( Table, Name, Path )
	end, 
	NewSource = function( Table, Name, Path, Type )
		loveloader.newSource( Table, Name, Path, Type )
	end, 
	NewSoundData = function( Table, Name, PathOrDecoder )
		loveloader.newSoundData( Table, Name, PathOrDecoder )
	end, 
	NewImageData = function( Table, Key, Path )
		loveloader.newImageData( Table, Key, Path )
	end, 
	Start = function( OnComplete, OnLoad )
		loveloader.start( OnComplete, OnLoad )
		-- OnLoad( Type <String>, Holder <Table>, Key <String> )
	end, 
	Update = function() loveloader.update() end
}