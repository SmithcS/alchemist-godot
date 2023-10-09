#!/home/braeden/_godot/Godot_v4.1.1-stable_linux.x86_64 -S godot -s
extends SceneTree

const Heap = preload("res://heap.gd")

var display: bool = false
var print_tree: bool = false
var show_tail: bool = false

func _init():
    seed(123)
    var heap: Heap = Heap.new()
    for value in range(300):
        heap.enque(randi_range(1, 1024))
        if show_tail:
            print("tail postion: %s" % heap._tail)
        if print_tree and display:
            print(heap.display())
        elif display:
            print(heap._data)
    while not heap.is_empty():
        print("value removed: %s" % heap.deque())
        if show_tail:
            print("tail postion: %s" % heap._tail)
        if print_tree and display:
            print(heap.display())
        elif display:
            print(heap._data)
    print("complete")
    quit()

