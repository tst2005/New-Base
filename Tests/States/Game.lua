local Game = {}

function Game.Enter()
	print('Enter Game')
end

function Game.Exit()
	print( 'Exit Game' )
end

function Game.Update( dt )
	print( 'Update Game' )
end

return Game