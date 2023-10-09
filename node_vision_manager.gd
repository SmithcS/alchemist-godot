class_name NodeVisionManager

const RAY_DEBUG_NODE_NAME = "RayDebugLine"

var parent: Node
var sight_distance: int
var fov: int
var rays: Array[RayCast2D]

var _min_blind_spot_pixels: int = 16
var _center_ray_idx: int
var _rotation_increment_rad: float
var _rotation_increments: int

func _init(p_parent: Node, p_sight_distance: int, p_fov: int):	
	fov = p_fov
	sight_distance = p_sight_distance
	parent = p_parent
	
	var num_rays = _num_rays()
	rays.resize(num_rays)

	_center_ray_idx = (num_rays / 2)
	_rotation_increments = (num_rays / 2)
	_rotation_increment_rad = deg_to_rad(fov / num_rays)

	# Create center ray first, then add rays to left and right of center
	# simultaneously until all rays have been created
	var rot = 0
	_create_ray(_center_ray_idx, rot)

	var left_ray_from_center_idx = _center_ray_idx
	var right_ray_from_center_idx = _center_ray_idx
	for _inc in range(_rotation_increments):
		rot += _rotation_increment_rad
		right_ray_from_center_idx += 1
		left_ray_from_center_idx -= 1
		_create_ray(right_ray_from_center_idx, rot)
		_create_ray(left_ray_from_center_idx, -rot)
	
func align_with_target(target: Node):
	var rot = 0
	_update_ray(_center_ray_idx, rot, target)

	var left_ray_from_center_idx = _center_ray_idx
	var right_ray_from_center_idx = _center_ray_idx
	for _inc in range(_rotation_increments):
		rot += _rotation_increment_rad
		right_ray_from_center_idx += 1
		left_ray_from_center_idx -= 1
		_update_ray(right_ray_from_center_idx, rot, target)
		_update_ray(left_ray_from_center_idx, -rot, target)

func is_colliding() -> bool:
	return rays.any(func(ray: RayCast2D): return ray.is_colliding())

func get_collider() -> Array:
	var collisions = rays.map(func(ray): return ray.get_collider())
	return collisions.filter(func(obj): return obj != null)

# Calculate number of rays to create based on the field of view such that an
# object at least the size of the minimum blind spot value will always be seen.
func _num_rays() -> int:
	var circle_of_vision_circumference = sight_distance * (2 * PI)
	var vision_arc_length = circle_of_vision_circumference * (fov / 360.0)
	var min_num_rays = int(ceil(vision_arc_length / _min_blind_spot_pixels))
	
	if ((min_num_rays % 2) == 0):
		return min_num_rays + 1
	return min_num_rays

func _create_ray(p_idx: int, p_rotation: float):
	var direction := Vector2(cos(p_rotation), sin(p_rotation))
	var sight_vector := direction * sight_distance
	
	var ray := RayCast2D.new()
	ray.target_position = sight_vector

	var ray_debug_line := Line2D.new()
	ray_debug_line.add_point(Vector2(0, 0))
	ray_debug_line.add_point(sight_vector)
	ray_debug_line.width = 1
	ray_debug_line.name = "RayDebugLine"

	ray.add_child(ray_debug_line)
	parent.add_child(ray)

	rays[p_idx] = ray

func _update_ray(p_idx: int, p_rotation: float, p_target: Node):
	var ray := rays[p_idx]
	var ray_debug_line: Line2D = ray.get_node(RAY_DEBUG_NODE_NAME)

	var direction: Vector2 = parent.position.direction_to(p_target.position)
	direction = direction.rotated(p_rotation)

	ray.target_position = sight_distance * direction
	ray_debug_line.set_point_position(1, ray.target_position)
