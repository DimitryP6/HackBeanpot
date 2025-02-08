extends Node2D

# Variables
var fact = "Your name is Dimitry"
var days_left = 15  # Example: Replace with actual days left
var attemps = days_left - 10  # Example: Reverse logic
var counter = 0
var correct_clicks = 0
var attempts = 3
var current_attempt = 0

# Nodes
@onready var card = $Background/Card
@onready var start_button = $Background/StartButton
@onready var symbol = $Background/Symbol
@onready var result = $Background/Result
@onready var delay_timer = $DelayTime
@onready var symbol_timer = $ReactTime
@onready var start_timer = $StartTimer
@onready var start_countdown = $Background/Start

"""
Ready and process functions to process frames and initialize nodes
"""

func _ready():
	# Connect signals
	start_button.pressed.connect(Callable(self, "_on_start_button_pressed"))
	card.pressed.connect(Callable(self, "_on_card_pressed"))
	delay_timer.timeout.connect(Callable(self, "_on_delay_time_timeout"))
	symbol_timer.timeout.connect(Callable(self, "_on_react_time_timeout"))
	start_timer.timeout.connect(Callable(self, "_on_timer_timeout"))
	
func _process(delta: float) -> void:
	if start_countdown != null:
		start_countdown.text = "%02d" % start_timer.time_left	
	
"""
5 main states:
	1. start 
	2. game 
	3. transition into fact
	4. fact
	5. reset for next day
"""

func _on_card_pressed():
	if symbol.text == "🚗":
		correct_clicks += 1
	else:
		current_attempt += 1
		if current_attempt >= attempts:
			result.text = "Out of attempts. Try again tomorrow."
		else:
			result.text = "Try again!"
	
func _on_start_button_pressed():
	print("WASSUP")
	start_button.queue_free()
	start_timer.start()
	
	
func _on_start_timer_timeout():
	start_countdown.queue_free()
	start_reaction_game()

func start_reaction_game():
	# Reset clicks and start the reaction game
	correct_clicks = 0
	delay_timer.start()
	print("start")

	

func _on_delay_time_timeout():
	# Show a random symbol (car or deer)
	var random_symbol = randi() % 2  # 0 = car, 1 = deer
	if random_symbol == 0:
		symbol.text = "🚗"
		counter += 1
	else:
		symbol.text = "🦌"
		print("delay")
	symbol_timer.start()

func _on_react_time_timeout():
	print(counter)
	if counter > attempts+1:
		return
	print(symbol.text)
	# Check the user's reaction
	
	# Reset the symbol
	symbol.text = "🛑"
	print("react")
	delay_timer.start()
	
