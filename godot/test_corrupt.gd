extends "res://test_load.gd"

func run() -> void:
	root.size = Vector2i(1280, 900)
	demo = load("res://runtime_save_load.tscn").instantiate()
	root.add_child(demo)
	demo.file_path_edit.text_submitted.connect(func(_text: String): submissions += 1)
	await process_frame
	var fixture_dir := OS.get_cmdline_user_args()[0]
	print("FIXTURES ", fixture_dir)
	for ext in ["png", "ogg", "zip", "ttf", "gltf"]:
		# Direct decoder diagnostic; fixtures are plain text with media suffixes.
		demo.open_file(fixture_dir.path_join("invalid." + ext))
		await process_frame
		check(demo.error_label.visible and demo.export_button.disabled, "corrupt " + ext + " gives non-exportable error")
		await submit("examples/misc/file.txt")
		check(demo.plain_text_viewer.visible and not demo.error_label.visible, "recover after corrupt " + ext)
	print("CORRUPT failures=", failures)
	demo.queue_free()
	await process_frame
	quit(1 if failures else 0)
