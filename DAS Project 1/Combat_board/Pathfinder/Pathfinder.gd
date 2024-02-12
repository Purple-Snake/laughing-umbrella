class_name PathFinder
extends Resource

var _grid: Resource
var astar_grid := AStarGrid2D.new()

func _init(grid: Grid, walkable_cells: Array) -> void:
	_grid = grid
	astar_grid.size = _grid.size
	astar_grid.cell_size = _grid.cell_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.update()
	
	for y in _grid.size.y:
		for x in _grid.size.x:
			if not walkable_cells.has(Vector2(x,y)):
				astar_grid.set_point_solid(Vector2(x,y))


func calculate_point_path(start: Vector2, end: Vector2) -> PackedVector2Array:
	return astar_grid.get_id_path(start, end)
