class_name CountDownTicker extends Resource

signal ticker_ended()

var _timer: float = 0.0

func set_ticker(timer: float):
	if timer <= 0:
		complete()
	else:
		_timer = timer
		
	
func tick(delta: float):
	if _timer > 0:
		_timer -= delta
		if is_completed():
			ticker_ended.emit()
			
func complete():
	_timer = 0
	ticker_ended.emit()

func is_completed() -> bool:
	return _timer <= 0
	
func get_time():
	return _timer
