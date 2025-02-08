extends Area2D

const SPEED:int = 50
const SNAP_MARGIN = 64
const OFFSET:Vector2 = Vector2(SNAP_MARGIN/2, SNAP_MARGIN/2)

var has_mouse:bool = false
var is_dragging:bool = false

func _on_mouse_entered():
	has_mouse = true

func _on_mouse_exited():
	has_mouse = false

func _process(delta):
	if has_mouse and Input.is_action_pressed("left_click"):
		is_dragging = true
		
	if is_dragging: 
		global_position = global_position.lerp(get_global_mouse_position() - OFFSET, SPEED*delta)
		
	if Input.is_action_just_released("left_click"):
		global_position.x = snapped(global_position.x, SNAP_MARGIN)
		global_position.y = snapped(global_position.y, SNAP_MARGIN)
		is_dragging = false
