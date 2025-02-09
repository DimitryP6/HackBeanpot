extends State
# Initialize nodes
@onready var card = get_parent().get_parent().get_node("Background/Card")
@onready var start_button = get_parent().get_parent().get_node("Background/StartButton")
@onready var result = get_parent().get_parent().get_node("Background/Result")
@onready var delay_timer = get_parent().get_parent().get_node("DelayTime")
@onready var symbol_timer = get_parent().get_parent().get_node("ReactTime")
@onready var start_timer = get_parent().get_parent().get_node("StartTimer")
@onready var start_countdown = get_parent().get_parent().get_node("Background/Start")
@onready var go_button = get_parent().get_parent().get_node("Background/GoButton")

@onready var deer = get_parent().get_parent().get_node("Background/Deer")
@onready var car = get_parent().get_parent().get_node("Background/Car")
@onready var stop = get_parent().get_parent().get_node("Background/Stop")


# Game variables
var correct_clicks = 0
var attempts = 5
var current_attempt = 0
var success = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card.pressed.connect(Callable(self, "_on_card_pressed"))
	delay_timer.timeout.connect(Callable(self, "_on_delay_time_timeout"))
	symbol_timer.timeout.connect(Callable(self, "_on_react_time_timeout"))
	go_button.pressed.connect(Callable(self, "_on_go_button_pressed"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	start_timer.start()
	start_reaction_game()
	
	
func exit():
	start_timer.queue_free()
	delay_timer.queue_free()
	go_button.queue_free()
	deer.queue_free()
	car.queue_free()
	stop.queue_free()
	
	
func update(_delta: float):
	pass
	
func _on_go_button_pressed():
	if car.visible:
		correct_clicks += 1
	if deer.visible:
		result.text = "WOOPSIE"
		Transitioned.emit(self, "Transition")
	
	


func start_reaction_game():
	# Reset clicks and start the reaction game
	correct_clicks = 0
	delay_timer.start()


func _on_delay_time_timeout():
	if stop != null:
		stop.hide()
	# Show a random symbol (car or deer)
	var random_symbol = randi() % 2  # 0 = car, 1 = deer
	if random_symbol == 0:
		car.visible = true
		current_attempt += 1
	else:
		deer.visible = true
		print("delay")
	symbol_timer.start()

func _on_react_time_timeout():
	print(correct_clicks)
	if current_attempt >= attempts:
		if correct_clicks == attempts:
			result.text = "Nice you won!"
			success = true
			Transitioned.emit(self, "Transition")
		else:
			result.text = "Better luck next time!"
			Transitioned.emit(self, "Transition")
	if car and deer != null:
		car.hide()
		deer.hide()
	# Reset the symbol
	stop.visible = true
	print("react")
	delay_timer.start()
