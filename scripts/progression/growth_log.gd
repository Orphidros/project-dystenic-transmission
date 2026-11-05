class_name GrowthLog
extends Node
## The growth-credit log (D-01). It records every judged input and spends nothing in Tier 1.
## Its schema follows session 1's default proposal: grade, signed offset, offset applied,
## context, character and chain index. Each session writes a fresh JSON Lines file.

const PATH := "user://growth_log.jsonl"

var entries: Array[Dictionary] = []
var credits: Dictionary = {}  # character name -> count of Perfect and Good
var _file: FileAccess


func _ready() -> void:
	_file = FileAccess.open(PATH, FileAccess.WRITE)


func record(grade: int, offset_ms: float, applied_offset_ms: float, context: String, character: String, chain_index: int) -> void:
	var e := {
		"t_usec": Time.get_ticks_usec(),
		"grade": RhythmWindows.grade_name(grade),
		"offset_ms": snappedf(offset_ms, 0.1),
		"applied_offset_ms": applied_offset_ms,
		"context": context,
		"character": character,
		"chain_index": chain_index,
	}
	entries.append(e)
	if RhythmWindows.is_credit(grade):
		credits[character] = int(credits.get(character, 0)) + 1
	if _file:
		_file.store_line(JSON.stringify(e))
		_file.flush()
