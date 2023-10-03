extends Node

# Place to define custom signals that cannot otherwise be defined in a script,
# e.g. when that script cannot be instanced so that other scripts can connect
# to its signals. 
#
# Usage:
# 
#   - Define signals
#   signal my_signal(my_param: int)
#
#   - Connect to signal from consuming script
#   EventBus.my_signal.connect(func_to_call_for_signal)
#
#   - Emit signal from producing script:
#   var some_int: int = 1
#   EventBus.my_signal.emit(some_int)
#
#   NOTE: If a type is explicitly defined in the signal like in the above
#   example with `my_param: int`, then the type of the value provided when
#   emitting the signal MUST be explicitly defined as well, like done in the
#   producing script example. Otherwise, emitting the signal will silently fail
#   because of a type mismatch (ask me how I figured this out).

signal hand_drawn(cards: Array[Card])
