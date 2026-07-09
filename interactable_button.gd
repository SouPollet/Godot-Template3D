extends StaticBody3D

@export var normal_material: Material
@export var hover_material: Material

@onready var mesh_node: MeshInstance3D = $Bouton

var is_hovered := false

func _ready():
	# Auto-detect the visual mesh child
	if not mesh_node:
		mesh_node = get_child(0) as MeshInstance3D

func _set_hover(hovered: bool):
	# ⚡ Early exit prevents redundant updates (fixes hover stutter completely)
	if is_hovered == hovered:
		return
	is_hovered = hovered

	# Validate setup before swapping
	if not mesh_node or not normal_material or not hover_material:
		printerr("⚠️ Missing mesh or materials! Assign them in the Inspector.")
		return

	# 🚀 Fast material swap - zero allocations, pure pointer switch
	mesh_node.material_override = hover_material if hovered else normal_material
