# Slow down time with an ease out effect to set 'momentum' when something 
# great happen
extends Node2D
class_name Momentum

export (float) var DURATION := 0.07
export (float) var STRENGTH := 1.0

const END_VALUE = 1
var is_active := false
var time_start := 0.0
var duration_ms := 0.0
var start_value := 0.0


# start momentum
func momentum() -> void:
	time_start = OS.get_ticks_msec()
	duration_ms = DURATION * 1000
	start_value = 1 - STRENGTH
	Engine.time_scale = start_value
	is_active = true


# @param {float} delta
func _process(delta: float) -> void:
	if is_active:
		var current_time: float = OS.get_ticks_msec() - time_start
		var value: float = circl_ease_in(current_time, start_value, END_VALUE, duration_ms)
		if current_time >= duration_ms:
			is_active = false
			value = END_VALUE
		Engine.time_scale = value


# ease in effect
# @param {float} time
# @param {float} start
# @param {float} end
# @param {float} duration
func circl_ease_in(time: float, start: float, end: float, duration: float) -> float:
	time /= duration
	return -end * (sqrt(1 - time * time) - 1) + start
