extends Node

@onready var raycast: RayCast3D = $"./CharacterBody3D/Head/Camera3D/InteractRay"
var current_hovered_body: StaticBody3D = null

func _process(_float):
	if not raycast or not raycast.enabled:
		return
	
	raycast.force_raycast_update()
	var collider = raycast.get_collider()

	var new_body: StaticBody3D = null
	if collider is StaticBody3D:
		if collider.has_method("_set_hover"):
			new_body = collider

	# Only trigger updates when hover state actually changes
	if new_body != current_hovered_body:
		if current_hovered_body:
			current_hovered_body._set_hover(false)
		current_hovered_body = new_body
		if current_hovered_body:
			current_hovered_body._set_hover(true)

func _input(event):
	# Direct left-click detection (more reliable than "ui_accept")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_hovered_body:
			#print("✅ Click detected on:", current_hovered_body.name)
			_spawn_object(current_hovered_body)
		#else:
			#print("❌ Click missed! No valid button under cursor.")

func _spawn_object(body: StaticBody3D):
	# 👈 REPLACE THIS PATH WITH YOUR ACTUAL SPAWN SCENE
	var spawn_scene = preload("res://basketball.tscn")
	var new_obj = spawn_scene.instantiate()

	# Add to current scene (swap to $Spawns/Container later if desired)
	get_tree().current_scene.add_child(new_obj)

	# Position slightly in front of the button along camera forward direction
	new_obj.global_position = body.global_position + raycast.global_transform.basis.z * 1.0
	#print("📦 Spawned at:", new_obj.global_position)
