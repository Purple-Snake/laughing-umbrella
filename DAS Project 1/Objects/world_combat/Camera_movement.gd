extends Camera2D

var fixed_toggle_point = Vector2(0,0)
var zoom_level = get_zoom()

@export var grid: Resource


func _process(_delta):
	if Input.is_action_just_pressed('move_map'):
		var ref = get_viewport().get_mouse_position()
		fixed_toggle_point = ref
	if Input.is_action_pressed('move_map'):
		move_map_around()
	
	zoom()

func zoom():
	if Input.is_action_just_released("zoom_out"):
		set_zoom(get_zoom() - Vector2(0.25, 0.25))
	if Input.is_action_just_released("zoom_in"):
		set_zoom(get_zoom() + Vector2(0.25, 0.25))

func move_map_around():
	var ref = get_viewport().get_mouse_position()
	self.global_position.x -= (ref.x - fixed_toggle_point.x)
	self.global_position.y -= (ref.y - fixed_toggle_point.y)
	fixed_toggle_point = ref
