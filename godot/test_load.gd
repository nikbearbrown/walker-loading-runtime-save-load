extends SceneTree

var failures := 0
var demo: Node
var submissions := 0
func _initialize() -> void:
	call_deferred("run")
func check(ok: bool, label: String) -> void:
	print("PASS " if ok else "FAIL ", label)
	if not ok:
		failures += 1
func submit(path: String) -> void:
	var previous := submissions
	demo.file_path_edit.text = ProjectSettings.globalize_path("res://" + path)
	demo.file_path_edit.grab_focus()
	for pressed in [true, false]:
		var mouse := InputEventMouseButton.new()
		mouse.position = demo.file_path_edit.get_global_rect().get_center()
		mouse.global_position = mouse.position
		mouse.button_index = MOUSE_BUTTON_LEFT
		mouse.pressed = pressed
		root.push_input(mouse, true)
	for pressed in [true, false]:
		var event := InputEventKey.new()
		event.keycode = KEY_ENTER
		event.pressed = pressed
		root.push_input(event, true)
		await process_frame
	await process_frame
	check(submissions == previous + 1, "Enter submitted " + path)
func run() -> void:
	root.size = Vector2i(1280, 900)
	demo = load("res://runtime_save_load.tscn").instantiate()
	root.add_child(demo)
	demo.file_path_edit.text_submitted.connect(func(_text: String): submissions += 1)
	await process_frame
	await submit("examples/misc/file.txt")
	check(demo.plain_text_viewer.visible and demo.plain_text_viewer_label.text == FileAccess.get_file_as_string("res://examples/misc/file.txt"), "text submission loads exact source")
	for ext in ["png", "jpg", "webp", "svg", "tga", "bmp"]:
		await submit("examples/images/godot_icon." + ext)
		check(demo.texture_viewer.visible and demo.texture_viewer.texture != null and demo.texture_viewer.texture.get_width() > 0, "image loaded " + ext)
	for font in ["inter_black.otf", "newsreader_9pt_regular.ttf", "hack_regular.woff2"]:
		await submit("examples/fonts/" + font)
		check(demo.font_viewer.visible and demo.export_button.disabled and not demo.font_viewer.get_theme_font("font").data.is_empty(), "runtime font loaded " + font)
	for ext in ["ogg", "mp3", "wav"]:
		await submit("examples/audio/item_spawn." + ext)
		check(demo.audio_player.visible and demo.export_button.disabled and demo.audio_stream_player.stream.get_length() > 0, "audio decoded " + ext)
	await submit("examples/misc/example.zip")
	check(demo.zip_viewer.visible and demo.zip_viewer_file_list.item_count > 0, "ZIP archive entries loaded")
	print("HEADLESS LOAD ONLY; no exports, playback, glTF or pixels verified; failures=", failures)
	demo.zip_reader.close()
	demo.queue_free()
	await process_frame
	quit(1 if failures else 0)
