extends Camera2D

@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0
@export var zoom_duration: float = 0.2
@export var zoom_factor: float = 0.1
var _default_elapsed_time: float = 0.0
var _zoom_level: float = 1.0:
	get: return _zoom_level
	set(num): 
		_set_zoom_level(num)
		_zoom_level = clamp(num, min_zoom, max_zoom)

# Setter for zoom level: interporateds the zoom level
func _set_zoom_level(num: float) -> void :
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", Vector2(_zoom_level, _zoom_level), zoom_duration)
	tween.play()

func _input(event):
	if Input.is_action_pressed("zoom_in"):
		_zoom_level += zoom_factor
	if Input.is_action_pressed("zoom_out"):
		_zoom_level -= zoom_factor
