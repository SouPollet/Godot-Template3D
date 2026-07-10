extends RigidBody3D

@export var feedback_mesh: MeshInstance3D    # Drag & drop your outline mesh here
var is_hovered := false
var is_dragging := false
var drag_offset := Vector3.ZERO
var last_mouse_pos := Vector2(-1, -1)

func _ready():
	if not feedback_mesh:
		print("⚠️ Please assign a MeshInstance3D in the Inspector!")
		return
	feedback_mesh.visible = false

func _process(_float):
	var current_mouse_pos := get_viewport().get_mouse_position()
	var mouse_moved := current_mouse_pos != last_mouse_pos
	last_mouse_pos = current_mouse_pos

	var mouse_pressed := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	# 🖱️ Only run raycasts when mouse moves (avoids per-frame lag)
	if mouse_moved:
		update_hover_state()

	# Drag state machine
	if mouse_pressed and not is_dragging:
		check_start_drag()
	elif !mouse_pressed and is_dragging:
		release_drag()

	if is_dragging and mouse_pressed:
		drag_object()

func check_start_drag():
	update_hover_state()
	if is_hovered:
		is_dragging = true
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		
		var hit_point = get_cursor_ray_point()
		if hit_point != null:
			drag_offset = global_position - hit_point

func drag_object():
	var new_hit = get_cursor_ray_point()
	if new_hit != null:
		global_position = new_hit + drag_offset

func release_drag():
	is_dragging = false
	if feedback_mesh:
		feedback_mesh.visible = is_hovered
	print("Dropped at:", global_position)

func update_hover_state():
	var cam := get_viewport().get_camera_3d()
	if not cam: return
	
	var mouse_pos := get_viewport().get_mouse_position()
	var ray_dir := cam.project_ray_normal(mouse_pos)
	var ray_origin := cam.global_transform.origin + ray_dir * 0.1
	
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_origin + ray_dir * 50.0
	query.collide_with_bodies = true
	query.collide_with_areas = false
	
	var result := space_state.intersect_ray(query)
	is_hovered = (result and result.get("collider") == self)
	
	if feedback_mesh:
		feedback_mesh.visible = is_hovered

func get_cursor_ray_point() -> Variant:
	var cam := get_viewport().get_camera_3d()
	if not cam: return null
	
	var mouse_pos := get_viewport().get_mouse_position()
	var ray_dir := cam.project_ray_normal(mouse_pos)
	var ray_origin := cam.global_transform.origin + ray_dir * 0.1
	
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_origin + ray_dir * 50.0
	query.collide_with_bodies = true
	query.collide_with_areas = false
	
	var result := space_state.intersect_ray(query)
	if result and result.get("collider") == self:
		return result.position
	return null
