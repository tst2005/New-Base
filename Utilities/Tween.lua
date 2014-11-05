local tween = require 'Utilities.Third Party.tween'
local OriginalMeta = getmetatable( tween.new( 1, { 1 }, { 1 } ) )
local Tween = {}
Tween.__index = Tween
setmetatable( Tween, OriginalMeta )
Tween.Easing = tween.easing

-- tween.lua functions
function Tween.New( Time, Subject, Target, Easing )
	local New = tween.new( Time, Subject, Target, Easing )
	New.__index = Tween
	setmetatable( New, Tween )
	return New
end

function Tween.Update( Self, dt )
	return Self:update( dt )
end

function Tween.Set( Self, Clock )
	return Self:set( Clock )
end

function Tween.Reset( Self )
	Self:reset()
end

-- Duration
function Tween.SetDuration( Self, Duration ) Self.duration = Duration; return Self end
function Tween.GetDuration( Self ) return Self.duration end
-- Subject
function Tween.SetSubject( Self, Table ) Self.subject = Table; return Self end
function Tween.GetSubject( Self ) return Self.subject end
-- Target
function Tween.SetTarget( Self, Table ) Self.target = Table; return Self end
function Tween.GetTarget( Self ) return Self.target end
-- Easing
function Tween.SetEasing( Self, Type ) Self.easing = Type; return Self end
function Tween.GetEasing( Self ) return Self.easing end
-- Initial
function Tween.SetInitial( Self, Values ) Self.initial = Values; return Self end
function Tween.GetInitial( Self ) return Self.initial end
-- Clock
function Tween.GetTime( Self ) return Self.clock end

return Tween