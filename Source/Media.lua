local Loader = require 'Utilities.Loader'

local Media = {
	--[[ 
		Table = {
			{ Name, Path }
		}
	]]
	Images = {}, 
	Fonts = {}, 
	Sources = {}, 
	SoundData = {}, 
	ImageData = {}, 
}

local function Register()
	for Index = 1, #Media.Images do Loader.NewImage( Media.Images, Media.Images[Index][1], Media.Images[Index][2] ) end
	for Index = 1, #Media.Fonts do Loader.NewFont( Media.Fonts, Media.Fonts[Index][1], Media.Fonts[Index][2] ) end
	for Index = 1, #Media.Sources do Loader.NewSource( Media.Sources, Media.Sources[Index][1], Media.Sources[Index][2] ) end
	for Index = 1, #Media.SoundData do Loader.NewSoundData( Media.SoundData, Media.SoundDatas[Index][1], Media.SoundDatas[Index][2] ) end
	for Index = 1, #Media.ImageData do Loader.NewImageData( Media.ImageData, Media.ImageDatas[Index][1], Media.ImageDatas[Index][2] ) end
end

function Media.Start( OnComplete, OnLoad )
	OnComplete = OnComplete or function() print 'All media loaded!' end
	OnLoad =  OnLoad or function( Type, Holder, Key ) print( table.concat{'Loaded media: \'', Type, '\': ', Key } ) end
	Register()
	Loader.Start( OnComplete, OnLoad )
end

function Media.Update()
	Loader.Update()
end


return Media