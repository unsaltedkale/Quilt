class_name PlayerRes extends Resource 

@export_category("BASE MOVMENT")
@export var walk_speed: float
@export var jump_vel: float

@export_category("FALLING")
@export var max_fall_vel: float
@export var grav_accel: float

@export_category("RECOIL")
@export var shooting_force: Vector2

@export_category("WALL JUMP")
@export var wall_jump_force: Vector2
@export var wall_slide_accel: float
