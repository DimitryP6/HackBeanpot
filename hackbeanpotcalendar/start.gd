extends State
@onready var start_button = get_parent().get_parent().get_node("Background/StartButton")
@onready var start_timer = get_parent().get_parent().get_node("StartTimer")
@onready var start_countdown = get_parent().get_parent().get_node("Background/Start")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect(Callable(self, "_on_start_button_pressed"))
	start_timer.timeout.connect(Callable(self, "_on_start_timer_timeout"))
	
func _on_start_button_pressed():
	start_timer.start()
	start_button.queue_free()
	
	
func _on_start_timer_timeout():
	if start_countdown != null:
		start_countdown.queue_free()
	Transitioned.emit(self, "Game")
		
	

func update(_delta):
	if start_countdown != null:
		start_countdown.text = "%02d" % start_timer.time_left
	
