extends Node

var current_state : State
var states : Dictionary = {} 
@onready var initial_state = $Start

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func on_child_transition(state : State, new_state_name : String):
	print("WAZZUP")
	state.exit()
	var new_state = states.get(new_state_name.to_lower())
	new_state.enter()
	if state != current_state:
		return
	if !new_state:
		return
	current_state = new_state
