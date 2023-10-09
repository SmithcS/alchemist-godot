class_name NodeVisionManager

var parent: Node
var sight_distance: int
var fov: int
var rays: Array[RayCast2D]

var _min_blind_spot: int = 16

func _num_rays():
	var circumference = sight_distance * (2 * PI)
	print(circumference)
	print((fov / 360.0))
	var sight_area = circumference * (fov / 360.0)
	print(sight_area)
	print(ceil(sight_area / _min_blind_spot))
	return ceil(sight_area / _min_blind_spot)

func _init(p_parent: Node, p_sight_distance: int, p_fov: int):
	if (p_fov % 5 != 0):
		print("FOV must be multiple of 5")
	
	fov = p_fov
	sight_distance = p_sight_distance
	parent = p_parent
	
	var num_rays = _num_rays()
	print(num_rays)
	var rot = 0
	var rot_increment = ((fov / num_rays) / 360) * (2 * PI)
	
	for i in num_rays:
		var direction = Vector2(cos(rot), sin(rot))
		var sight_vector = direction * sight_distance
		
		var ray: RayCast2D = RayCast2D.new()
		ray.target_position = sight_vector
		
		var ray_debug_line: Line2D = Line2D.new()
		ray_debug_line.add_point(Vector2(0, 0))
		ray_debug_line.add_point(sight_vector)
		ray_debug_line.width = 1
		ray_debug_line.name = "RayDebugLine"

		ray.add_child(ray_debug_line)
		print(ray.get_children())
		parent.add_child(ray)
		
		rot += rot_increment
		
		rays.append(ray)
	
# Can use rotation 
func _align_with_target(target: Node):
	print("getting here")
	var rot = 0
	var rot_increment = ((fov / _num_rays()) / 360) * (2 * PI)
	for ray in rays:
		var ray_debug_line: Line2D = ray.get_node("RayDebugLine")
		var direction: Vector2 = (target.position - parent.position).normalized()
		direction = direction.rotated(rot)
		
		rot += rot_increment
		
		ray.target_position = sight_distance * direction
		ray_debug_line.set_point_position(1, ray.target_position)

func is_colliding():
	for ray in rays:
		if ray.is_colliding():
			return true
	return false

func get_collider():
	var colliders = rays.map(func(ray): return ray.get_collider())
	
	var f = null
	for collider in colliders:
		f = collider
	return f

		
