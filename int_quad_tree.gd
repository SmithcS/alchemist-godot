extends Node


const _MINIMUM_WEIGHT: int = 8


func _init(y_size: int, x_size: int, inital_val: int = 0):
    # TODO limit size so the array behaves like a quadtree
    var _data:PackedInt32Array = PackedInt32Array()
    _data.resize(y_size*x_size)
    _data.fill(inital_val)
    var _last_free_value: int = 4


func get_value(y_index: int, x_index: int) -> int:
    # TODO return value at index i,j in the array
    # TODO support negative indexing
    return -1


func set_value(y_index: int, x_index: int):
    # TODO sets value in array, changes size if necessary
    pass


func _get_next_free() -> int:
    # TODO return the next free index
    return -1


func _free_index(index) -> int:
    # TODO frees index to be reclaimed latter.
    return -1


func _make_child(index: int):
    # TODO add child to tree
    pass

func _remove_child(index: int):
    # TODO add child to tree
    pass 


func _get_parent_index(index: int) -> int:
    # TODO returns parent index
    return -1 


func _get_children_indices(index: int, offset: int) -> int:
    # Return parent index
    # TODO insure offset is always a number between 0 and 3 - possibily an enum
    return -1

