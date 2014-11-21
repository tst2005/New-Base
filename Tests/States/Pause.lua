local Pause = {}

function Pause.Enter()
	print('Enter Pause')
end

function Pause.Exit()
	print( 'Exit Pause' )
end

function Pause.Update( dt )
	print( 'Update Pause' )
end

return Pause