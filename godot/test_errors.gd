extends "res://test_load.gd"

func run() -> void:
	root.size = Vector2i(1280, 900)
	demo = load("res://runtime_save_load.tscn").instantiate()
	root.add_child(demo)
	demo.file_path_edit.text_submitted.connect(func(_text: String): submissions += 1)
	await process_frame
	for ext in ["png", "ogg", "zip", "txt", "ttf", "gltf"]:
		await submit("examples/misc/file.txt")
		await submit("missing-walker-verification." + ext)
		check(demo.error_label.visible and demo.export_button.disabled, "missing " + ext + " gives non-exportable error")
		await submit("examples/misc/file.txt")
		check(demo.plain_text_viewer.visible and not demo.error_label.visible and not demo.export_button.disabled, "recover after missing " + ext)
	print("ERROR_PATH failures=", failures)
	demo.queue_free()
	await process_frame
	quit(1 if failures else 0)
