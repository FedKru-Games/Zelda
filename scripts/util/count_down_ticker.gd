class_name CountDownTicker extends Resource

var _timer: float = 0.0

func set_ticker(timer: float):
	_timer = timer
	
func tick(delta: float):
	if _timer > 0:
		_timer -= delta

func is_completed() -> bool:
	return _timer <= 0
