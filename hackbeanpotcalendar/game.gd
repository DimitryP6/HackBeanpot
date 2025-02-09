extends State
# Initialize nodes
@onready var card = get_parent().get_parent().get_node("Background/Card")
@onready var start_button = get_parent().get_parent().get_node("Background/StartButton")
@onready var symbol = get_parent().get_parent().get_node("Background/Symbol")
@onready var result = get_parent().get_parent().get_node("Background/Result")
@onready var delay_timer = get_parent().get_parent().get_node("DelayTime")
@onready var symbol_timer = get_parent().get_parent().get_node("ReactTime")
@onready var start_timer = get_parent().get_parent().get_node("StartTimer")
@onready var start_countdown = get_parent().get_parent().get_node("Background/Start")


# Game variables
var counter = 0
var correct_clicks = 0
var attempts = 3
var current_attempt = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card.pressed.connect(Callable(self, "_on_card_pressed"))
	delay_timer.timeout.connect(Callable(self, "_on_delay_time_timeout"))
	symbol_timer.timeout.connect(Callable(self, "_on_react_time_timeout"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	start_timer.start()
	start_reaction_game()
	
	
func exit():
	pass
	
func update(_delta: float):
	pass
	
func _on_card_pressed():
	if symbol.text == "🚗":
		correct_clicks += 1
	else:
		current_attempt += 1
		if current_attempt >= attempts:
			result.text = "Out of attempts. Try again tomorrow."
		else:
			result.text = "Try again!"
	
	


func start_reaction_game():
	# Reset clicks and start the reaction game
	correct_clicks = 0
	delay_timer.start()


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
