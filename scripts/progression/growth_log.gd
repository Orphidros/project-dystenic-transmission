class_name GrowthLog
extends Node
## The growth-credit log (CoD-01; OQ-067). It records every judged input and spends nothing in
## Tier 1. Only Perfect and Good count as growth credit (RhythmWindows.is_credit; author, 2026-11-20).
## Schema: grade, signed offset, offset applied, context, character and chain index. The schema
## waits on playtest data before it is fixed (OQ-056).
## Each session writes its own JSON Lines file, named with the date and time, and never overwrites
## an earlier one (Systems & Code build call, 2026-11-21). The first line is a session header with
## the start time and the Godot version.

const PREFIX := "user://growth_log_"

var path := ""
var entries: Array[Dictionary] = []
var credits: Dictionary = {}  # character name -> count of Perfect and Good
var _file: FileAccess


func _ready() -> void:
	path = new_session_path()
	_file = FileAccess.open(path, FileAccess.WRITE)
	if _file:
		_file.store_line(JSON.stringify({
			"session_start": Time.get_datetime_string_from_system(),
			"godot_version": str(Engine.get_version_info()["string"]),
		}))
		_file.flush()


## A file name nobody has used yet: growth_log_<date>_<time>.jsonl, plus _2, _3 and so on if
## two sessions start in the same second.
static func new_session_path() -> String:
	var stamp := Time.get_datetime_string_from_system().replace("T", "_").replace(":", "-")
	var base := PREFIX + stamp
	var candidate := base + ".jsonl"
	var n := 2
	while FileAccess.file_exists(candidate):
		candidate = "%s_%d.jsonl" % [base, n]
		n += 1
	return candidate


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
