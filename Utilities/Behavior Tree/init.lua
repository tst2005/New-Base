return {
	Behavior = 	require 'Utilities.Behavior Tree.Behavior', 
	Leaf = require 'Utilities.Behavior Tree.Leaf', 
	Root = require 'Utilities.Behavior Tree.Root', 
	
	Composite = {
		Selector = require 'Utilities.Behavior Tree.Composite.Selector', 
		Sequence = require 'Utilities.Behavior Tree.Composite.Sequence',
	}, 
	
	Decorator = {
		Base = require 'Utilities.Behavior Tree.Decorator.Decorator', 
		Failer = require 'Utilities.Behavior Tree.Decorator.Failer', 
		Inverter = require 'Utilities.Behavior Tree.Decorator.Inverter', 
		RepeatUntilFailer = require 'Utilities.Behavior Tree.Decorator.RepeatUntilFailer', 
		Succeeder = require 'Utilities.Behavior Tree.Decorator.Succeeder', 
		Timer = require 'Utilities.Behavior Tree.Decorator.Timer', 
	}, 
}