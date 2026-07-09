extends CharacterBody3D

#POUR LES CONTROLES A LA SOURIS
@onready var head: Node3D = $Head
@onready var camera_3d: Camera3D = $Head/Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003 #Sensibilité de la souris

#quitter l'app
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

#Capter le mouvement de la souris
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#Mouvement souris
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY) #Bouger la souris de gauche a droite bouge tete haut bas
		camera_3d.rotate_x(-event.relative.y * SENSITIVITY) #Bouger souris haut bas fait bouger cam gauche droite
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-80), deg_to_rad(80)) #Bloquer la rotation de camera sur l'axe 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
