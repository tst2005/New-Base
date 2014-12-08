local Loader = require 'Utilities.Loader'

local media = {
	--[[ 
		Table = {
			{ Name, Path }
		}
	]]
	images = {}, 
	fonts = {
		{ 'Silkscreen', 'Source/Third Party/fonts/Silkscreen/slkscreb.ttf', 64 }, 
	}, 
	sources = {}, 
	soundData = {}, 
	imageData = {}, 
}

local function register()
	for index = 1, #media.images do Loader.newImage( media.images, media.images[index][1], media.images[index][2] ) end
	for index = 1, #media.fonts do Loader.newFont( media.fonts, media.fonts[index][1], media.fonts[index][2], media.fonts[index][3] ) end
	for index = 1, #media.sources do Loader.newSource( media.sources, media.sources[index][1], media.sources[index][2], media.sources[index][3] ) end
	for index = 1, #media.soundData do Loader.newsoundData( media.soundData, media.soundData[index][1], media.soundData[index][2] ) end
	for index = 1, #media.imageData do Loader.newimageData( media.imageData, media.imageData[index][1], media.imageData[index][2] ) end
end

function media.start( onComplete, onLoad )
	onComplete = onComplete or function() print 'All media loaded!' end
	onLoad =  onLoad or function( type, holder, key ) print( table.concat{ 'Loaded media: \'', type, '\': ', key } ) end
	register()
	local reallyComplete = function() onComplete(); return true end
	Loader.start( reallyComplete, onLoad )
end

function media.update()
	return Loader.update()
end


return media