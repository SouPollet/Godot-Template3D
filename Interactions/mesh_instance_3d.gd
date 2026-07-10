extends MeshInstance3D

var base_color := Color(0.158, 0.494, 0.0, 1.0)
var hover_color := Color(1.0, 0.2, 0.5)  # Pink/purple for clear visual feedback
var is_hovered := false

func _ready():
	# Mark this node as a clickable button
	set_meta("_is_button", true)
	
	if material_override:
		base_color = material_override.albedo_color
	else:
		material_override = StandardMaterial3D.new()
		base_color = Color(0.158, 0.494, 0.0, 1.0)

func _set_hover(hovered: bool):
	is_hovered = hovered
	if material_override == null:
		material_override = StandardMaterial3D.new()
	
	var mat = material_override as StandardMaterial3D
	mat.albedo_color = hover_color if hovered else base_color
	
	# Godot 4 doesn't have native outline_width on StandardMaterial3D.
	# This gives a reliable visual feedback instead:
	mat.emission_enabled = hovered
	mat.emission = Color(1, 0.7, 0) if hovered else Color(0, 0, 0)
	mat.emission_intensity = 1.5 if hovered else 0.0
	
	print("🔵 Hover state changed to:", hovered)
