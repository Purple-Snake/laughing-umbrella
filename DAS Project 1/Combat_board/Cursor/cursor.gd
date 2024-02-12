@tool
class_name Cursor
extends Node2D

signal accept_pressed(cell)
signal moved(new_cell)

@export var grid: Resource


var cell := Vector2.ZERO:
	set(value):
		var new_cell: Vector2 = grid.grid_clamp(value)
		if new_cell.is_equal_approx(cell):
			return
		
		cell = new_cell
		position = grid.calculate_map_position(cell)
		emit_signal("moved", cell)

func _ready():
	position = grid.calculate_map_position(cell)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		cell = grid.calculate_grid_coordinates(event.position)
	elif event.is_action_pressed("Combat_click"):
		emit_signal("accept_pressed", cell)
		get_viewport().set_input_as_handled()
	
	var should_move = event.is_pressed()
	if event.is_echo():
		should_move = should_move
	
	if !should_move:
		return

#This draws the cursor square
#func _draw() -> void:
	#draw_rect(Rect2(-grid.cell_size / 2, grid.cell_size), Color.ALICE_BLUE, false, 2.0)
