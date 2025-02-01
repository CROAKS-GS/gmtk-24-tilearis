extends Camera2D

const PAN_LEFT: Vector2 = Vector2(-1, 0)
const PAN_RIGHT: Vector2 = Vector2(1, 0)
const PAN_UP: Vector2 = Vector2(0, -1)
const PAN_DOWN: Vector2 = Vector2(0, 1)

@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0
@export var zoom_duration: float = 0.2
@export var zoom_factor: float = 0.3
@export var pan_duration: float = 1.0
@export var pan_factor: float = 30
var velocity: Vector2 = Vector2.ZERO

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

# Camera Zoom
func _camera_zoom(is_zoom_in: bool):
	if(is_zoom_in):
		_zoom_level += zoom_factor
	else:
		_zoom_level -= zoom_factor

# Camera Panning
func _camera_pan(direction: Vector2, delta):
	self.global_position += direction * pan_factor
	
func _input(event):
	if Input.is_action_just_released("zoom_in"):
		_camera_zoom(true)
	if Input.is_action_just_released("zoom_out"):
		_camera_zoom(false)

func _physics_process(delta):
	if Input.is_action_pressed("camera_down"):
		_camera_pan(PAN_DOWN, delta)
	if Input.is_action_pressed("camera_left"):
		_camera_pan(PAN_LEFT, delta)
	if Input.is_action_pressed("camera_right"):
		_camera_pan(PAN_RIGHT, delta)
	if Input.is_action_pressed("camera_up"):
		_camera_pan(PAN_UP, delta)
