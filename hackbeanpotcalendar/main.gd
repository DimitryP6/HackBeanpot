extends Node2D

# Variables
var days_left = 15  # Example: Replace with actual days left
var clicks_required = days_left - 10  # Example: Reverse logic
var clicks = 0
var attempts = 3
var current_attempt = 0

# Nodes
@onready var card = $Card
@onready var symbol = $Symbol
@onready var result = $Result
@onready var go_signal = $DelayTime
@onready var symbol_timer = $ReactTime

func _ready():
	# Connect signals
	card.pressed.connect(Callable(self, "_on_card_pressed"))
	go_signal.timeout.connect(Callable(self, "_on_delay_time_timeout"))
	symbol_timer.timeout.connect(Callable(self, "_on_react_time_timeout"))

func _on_card_pressed():
	if go_signal.is_stopped() and symbol_timer.is_stopped():
		clicks += 1
		if clicks == clicks_required:
			start_reaction_game()
	print("hello beautiful man")

func start_reaction_game():
	# Reset clicks and start the reaction game
	clicks = 0
	go_signal.start()
	print("start")

func _on_delay_time_timeout():
	# Show a random symbol (car or deer)
	var random_symbol = randi() % 2  # 0 = car, 1 = deer
	if random_symbol == 0:
		symbol.text = "🚗"
	else:
		symbol.text = "🦌"
	symbol_timer.start()
	print("delay")

func _on_react_time_timeout():
	# Check the user's reaction
	if symbol.text == "🚗" and Input.is_action_just_pressed("ui_select"):
		result.text = "Success! Fun fact unlocked."
	else:
		current_attempt += 1
		if current_attempt >= attempts:
			result.text = "Out of attempts. Try again tomorrow."
		else:
			result.text = "Try again!"
	# Reset the symbol
	symbol.text = ""
	print("react")
