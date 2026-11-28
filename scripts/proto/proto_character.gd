class_name ProtoCharacter
extends CharacterBody3D
## A placeholder band member locked to DT's movement plane (z = 0).
## The inactive member follows the active one, a minimal stand-in for S1's
## Background Character Manager. Stress is hidden (O-07): only the tell shows it.

@export var display_name := "Vox"
@export var body_color := Color(0.8, 0.3, 0.3)
@export var tell_color := Color(1.0, 0.5, 0.2)
@export var speed := 5.0
@export var jump_velocity := 7.0

var active := false
var follow_target: ProtoCharacter
var stress := 0.0
var facing := 1.0

var _tell_mat: StandardMaterial3D
var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	collision_layer = 2  # Band members don't collide with each other.
	collision_mask = 1
	var shape := CollisionShape3D.new()
	var cap := CapsuleShape3D.new()
	cap.radius = 0.35
	cap.height = 1.8
	shape.shape = cap
	shape.position.y = 0.9
	add_child(shape)

	var body := MeshInstance3D.new()
	var cm := CapsuleMesh.new()
	cm.radius = 0.35
	cm.height = 1.8
	body.mesh = cm
	body.position.y = 0.9
	var mat := StandardMaterial3D.new()
	mat.albedo_color = body_color
	body.material_override = mat
	add_child(body)

	# The stress tell: Vox's throat hardware or Ciphera's holo-runes (placeholder).
	var tell := MeshInstance3D.new()
	var sm := SphereMesh.new()
	sm.radius = 0.09
	sm.height = 0.18
	tell.mesh = sm
	tell.position = Vector3(0.0, 1.45, 0.3)
	_tell_mat = StandardMaterial3D.new()
	_tell_mat.albedo_color = tell_color.darkened(0.6)
	_tell_mat.emission_enabled = true
	_tell_mat.emission = tell_color
	tell.material_override = _tell_mat
	add_child(tell)


func add_stress(amount: float) -> void:
	stress = clampf(stress + amount, 0.0, 100.0)


func _process(_delta: float) -> void:
	var s := stress / 100.0
	var flicker := 1.0
	if s > 0.3:
		flicker = 0.6 + 0.4 * sin(Time.get_ticks_msec() * 0.02 * (1.0 + 4.0 * s))
	_tell_mat.emission_energy_multiplier = (0.3 + 3.0 * s) * flicker


func _physics_process(delta: float) -> void:
	if not active:
		_follow(delta)
		return
	if not is_on_floor():
		velocity.y -= _gravity * delta
	if Input.is_action_just_pressed("dt_jump") and is_on_floor():
		velocity.y = jump_velocity
	var dir := Input.get_axis("dt_left", "dt_right")
	velocity.x = dir * speed
	if dir != 0.0:
		facing = signf(dir)
	velocity.z = 0.0
	move_and_slide()
	position.z = 0.0  # The plane lock: never drift off the movement plane.


func _follow(delta: float) -> void:
	if follow_target == null:
		return
	var tgt := follow_target.global_position + Vector3(-1.2 * follow_target.facing, 0.0, 0.0)
	global_position = global_position.lerp(Vector3(tgt.x, tgt.y, 0.0), clampf(delta * 4.0, 0.0, 1.0))
	velocity = Vector3.ZERO
