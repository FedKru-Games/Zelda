class_name ImpactParticles extends GPUParticles2D

@onready var timer: Timer = get_node("Timer")

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	
func start_emitting():
	timer.start(lifetime + 0.1)
	emitting = true
	
func _on_timer_timeout() -> void:
	queue_free()
