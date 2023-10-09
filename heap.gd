class_name Heap

var _data: PackedInt32Array
var _size: int
var _tail: int

const MIN_SIZE: int = 128

func _init():
    _tail = -1
    _size = MIN_SIZE
    _data = PackedInt32Array()
    _data.resize(_size)

func is_empty() -> bool:
    return _tail == -1

func deque() -> int:
    var outp: int = _data[0]
    _data[0] = _data[_tail]
    _data[_tail] = 0
    _tail = _tail - 1
    _swim_down(0)
    if 2*(_tail + 1) < _size and _size >= 2*MIN_SIZE:
        # print("Resizing to %s" % str(_size/2))
        _data.resize(_size/2)
    return outp


func enque(value: int):
    if _tail+1 == _size:
        _size *= 2
        # print("Resizing to %s" % str(_size))
        _data.resize(_size)
    _tail = _tail + 1
    _data[_tail] = value
    _swim_up(_tail)


func _swim_up(index: int):
    while index != 0:
        var _parent_index: int = _get_parent(index)
        if _data[index] < _data[_parent_index]:
            _swap(index, _parent_index)
            index = _parent_index
        else:
            break


func _swim_down(index: int):
    while index <= _tail:
        # print("LOCAL INFO:\n\tINDEX %s\n\tVALUE %s\n\tLEFT %s\n\tRIGHT %s" % [index, _data[index], _data[_get_left_child(index)], _data[_get_right_child(index)]])
        var _left_child_index: int = _get_left_child(index)
        var _right_child_index: int = _get_right_child(index)
        if _left_child_index > _tail:
            break
        elif _right_child_index > _tail:
            var _left_child_value: int = _data[_left_child_index]
            if _left_child_value < _data[index]:
                _swap(index, _left_child_index)
                index = _left_child_index
            else:
                break
        else:
            var _left_child_value: int = _data[_left_child_index]
            var _right_node_value: int = _data[_right_child_index]
            var _min_index: int = _left_child_index if _left_child_value <= _right_node_value else _right_child_index
            if _data[_min_index] <= _data[index]:
                _swap(index, _min_index)
                index = _min_index
            else:
                break 
    

func _swap(index1: int, index2: int):
    var temp = _data[index1]
    _data[index1] = _data[index2]
    _data[index2] = temp


func _get_parent(value: int ) -> int:
    return (value - 1)/2


func _get_left_child(value: int) -> int:
    return 2*value + 1


func _get_right_child(value: int) -> int:
    return 2*value + 2


func display() -> String:
    return _display_rec(0)


func _display_rec(index: int) -> String:
    if index > _tail:
        return str(0)
    else:
        return "%s[%s %s]" % [_data[index], _display_rec(_get_left_child(index)), _display_rec(_get_right_child(index))]