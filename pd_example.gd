extends SceneTree

const PriorityQueue = preload("res://priority_queue.gd")

var display: bool = false
var print_tree: bool = false
var show_tail: bool = false
var negative: bool = false

var words: Array[String] = ["cat", "dog", "wow", "sic"]

func _init():
    seed(123)
    var pq: PriorityQueue = PriorityQueue.new()
    if negative:
        pq = PriorityQueue.new(func(x,y): return x >= y)
    for value in range(100):
        var number: float = randf_range(0,1)
        var name: String = words[randi_range(0,3)] + str(number)
        pq.enque(number, name)
        if show_tail:
            print("tail postion: %s" % pq._helper.size())
        if print_tree and display:
            print(pq.display())
        elif display:
            print(pq._data)
    while not pq.is_empty():
        print("value removed: %s" % pq.deque())
        if show_tail:
            print("tail postion: %s" % pq._helper.size())
        if print_tree and display:
            print(pq.display())
        elif display:
            print(pq._data)
    print("complete")
    quit()