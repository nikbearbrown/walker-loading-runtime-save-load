extends "res://test_load.gd"

func run() -> void:
	root.size = Vector2i(1280, 900)
	var output := OS.get_cmdline_user_args()[0]
	print("ISOLATED_OUTPUT ", output)
	demo = load("res://runtime_save_load.tscn").instantiate()
	root.add_child(demo)
	demo.file_path_edit.text_submitted.connect(func(_text: String): submissions += 1)
	await process_frame
	await submit("examples/misc/file.txt")
	# Direct export handler calls are serialization diagnostics, not UI capture.
	demo._on_export_file_dialog_file_selected(output.path_join("text.txt"))
	check(FileAccess.get_file_as_string(output.path_join("text.txt")) == demo.plain_text_viewer_label.text, "text export round trip")
	await submit("examples/images/godot_icon.png")
	var source: Image = demo.texture_viewer.texture.get_image()
	for ext in ["png", "webp", "jpg"]:
		var path := output.path_join("image." + ext)
		demo._on_export_file_dialog_file_selected(path)
		var restored := Image.load_from_file(path)
		check(restored != null and restored.get_size() == source.get_size(), "image export dimensions " + ext)
		if ext != "jpg":
			restored.convert(Image.FORMAT_RGBA8)
			var comparison := source.duplicate()
			comparison.convert(Image.FORMAT_RGBA8)
			check(restored.get_data() == comparison.get_data(), "lossless pixel data round trip " + ext)
	await submit("examples/misc/example.zip")
	demo._on_export_file_dialog_file_selected(output.path_join("archive.zip"))
	var restored_zip := ZIPReader.new()
	check(restored_zip.open(output.path_join("archive.zip")) == OK, "exported ZIP opens")
	var original_names: PackedStringArray = demo.zip_reader.get_files()
	var restored_names := restored_zip.get_files()
	original_names.sort()
	restored_names.sort()
	print("ZIP_ORIGINAL ", original_names, " RESTORED ", restored_names)
	var equal: bool = restored_names == original_names
	for entry in demo.zip_reader.get_files():
		equal = equal and restored_zip.read_file(entry) == demo.zip_reader.read_file(entry)
	check(equal, "ZIP names and entry bytes preserved")
	restored_zip.close()
	demo.zip_reader.close()
	await submit("examples/3d_scenes/gltf/plastic_monobloc_chair_01_1k.gltf")
	var loaded: Node = demo.scene_viewer_root_node
	check(is_instance_valid(loaded) and demo.scene_viewer.visible, "glTF generates scene")
	check(loaded.get_viewport() == demo.scene_viewer_camera.get_viewport(), "loaded scene shares preview camera viewport")
	var glb_path := output.path_join("chair.glb")
	demo._on_export_file_dialog_file_selected(glb_path)
	check(FileAccess.file_exists(glb_path), "GLB export exists")
	var original_meshes := loaded.find_children("*", "MeshInstance3D", true, false).size()
	demo.open_file(glb_path)
	await process_frame
	check(not is_instance_valid(loaded), "replacing scene frees previous root")
	loaded = demo.scene_viewer_root_node
	check(loaded.find_children("*", "MeshInstance3D", true, false).size() == original_meshes and original_meshes > 0, "GLB reload preserves mesh instance count")
	var imported_count := 0
	for child in demo.scene_viewer_camera.get_parent().get_children():
		if child.has_meta("runtime_import"):
			imported_count += 1
	check(imported_count == 1, "repeated scene load leaves exactly one imported root")
	await submit("examples/misc/file.txt")
	await process_frame
	check(not is_instance_valid(loaded), "switching away frees imported scene")
	print("ROUNDTRIP failures=", failures, "; no visual or film verification")
	demo.queue_free()
	await process_frame
	quit(1 if failures else 0)
