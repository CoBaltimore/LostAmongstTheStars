extends Node2D

@export var initialState : state

var currentState : state
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is state:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(onChildTransition)
	
	if initialState:
		initialState.Enter()
		currentState = initialState

func _process(delta: float) -> void:
	if currentState:
		currentState.update(delta)

func _physics_process(delta: float) -> void:
	if currentState:
		currentState.Update(delta)

func onChildTransition(state, newStateName):
	if state != currentState:
		return
	
	var newState = states.get(newStateName.to_lower())
	if !newState:
		return
	
	if currentState:
		currentState.exit()
	
	newState.enter()
