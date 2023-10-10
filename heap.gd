class_name Heap

const HeapHelper = preload("res://heap_helper.gd")


var _data: PackedInt32Array
var _size: int
var _comp: Callable
var _helper: HeapHelper

const MIN_SIZE: int = 128

func _init(comp: Callable = (func(x,y): return x <= y)):
    _size = MIN_SIZE
    _data = PackedInt32Array()
    _data.resize(_size)
    _comp = comp
    _helper = HeapHelper.new(_data, _comp)

func is_empty() -> bool:
    return _helper.size() == -1

func deque() -> int:
    var outp: int = _data[0]
    _data[0] = _data[_helper.size()]
    _data[_helper.size()] = 0
    _helper.decr_size()
    _helper._swim_down(0)
    if 2*(_helper.size() + 1) < _size and _size >= 2*MIN_SIZE:
        # print("Resizing to %s" % str(_size/2))r
        _data.resize(_size/2)
    return outp


func enque(value: int):
    if _helper.size() + 1 == _size:
        _size *= 2
        # print("Resizing to %s" % str(_size))
        _data.resize(_size)
    _helper.incr_size()
    _data[_helper.size()] = value
    _helper._swim_up(_helper.size())


        