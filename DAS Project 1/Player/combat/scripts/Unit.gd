@tool
class_name Unit
extends Path2D

signal walk_finished

@export var grid: Resource
@export var move_range := 6
@export var move_speed := 100.0

@onready var _path_follow: PathFollow2D = $PathFollow2D

var cell := Vector2.ZERO:
	set(value):
		cell = grid.grid_clamp(value)

var is_selected := false:
	set(value):
		is_selected = value

var _is_walking := false:
	set(value):
		_is_walking = value
		set_process(_is_walking)


func _ready() -> void:
	set_process(false)
	_path_follow.rotates = false
	
	cell = grid.calculate_grid_coordinates(position)
	position = grid.calculate_map_position(cell)
	
	if not Engine.is_editor_hint():
		curve = Curve2D.new()
	

func _process(delta: float) -> void:
	_path_follow.progress += move_speed * delta
	
	if _path_follow.progress_ratio >= 1.0:
		_is_walking = false
		_path_follow.progress = 0.00001
		position = grid.calculate_map_position(cell)
		curve.clear_points()
		emit_signal("walk_finished")

func walk_along(path: PackedVector2Array) -> void:
	if path.is_empty():
		print("Error: Path is empty.")
		return
	
	curve.add_point(Vector2.ZERO)
	for point in path:
		curve.add_point(grid.calculate_map_position(point) - position)
	cell = path[-1]
	_is_walking = true
