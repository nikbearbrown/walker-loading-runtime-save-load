# Walker — Run-time File Saving and Loading

**What this is.** An independent copy of Godot's `loading/runtime_save_load`
demo: a file viewer that loads images, audio, 3D scenes, fonts, ZIP archives and
plain text at run time without Godot's import system, and exports the formats
that can be written back out. It is a tech demo, not a game.

**Why it is in Walker.** It is one of Walker's Godot demo adaptations: an
independent copy checked headlessly and queued for two Liam films (see
FRICTIONAL.md). Whether it should also be the basis for runtime user content in
Walker games is an open question (design/decisions.md, Q-01).

**What was found and verified.** Walker's local changes cover the title, the
imported-scene preview viewport/cleanup, ZIP directory export and
missing/corrupt-file handling. Import/runtime, 28 headless loading/submission
checks and 20 export/scene-state checks pass. A recovered design description now
exists in `GDD.md`; it describes the code and approves nothing.

## How to run

Open `godot/project.godot` in Godot 4.7 (evidence logs were produced with Godot
4.7.2) and run the project. The main scene is `runtime_save_load.tscn`.

Controls: type a file path and press Enter, or click **Browse** (sample files are
in `godot/examples/`). Press the audio button to play loaded audio; use the
slider under a 3D scene to zoom; click an entry in a ZIP to preview it. Click
**Export** to save the current file in another format where supported (text,
PNG/JPEG/WebP, glTF/GLB, ZIP; audio and fonts cannot be exported). There are no
custom input actions.

## Design

The design package is a **recovered, unapproved description** of what the code
does, written by the Walker `/gdd reverse` pass in silent mode. No design gate
has been signed.

- [GDD.md](GDD.md) — recovered Game Design Document (identical copy of `design/GDD.md`)
- [design/DECK.html](design/DECK.html) — review slides
- [design/IMPLEMENTATION-MAP.md](design/IMPLEMENTATION-MAP.md) — feature → scene/script paths
- [design/decisions.md](design/decisions.md) — open questions the code cannot answer

## Source & license

Independent copy of Godot `loading/runtime_save_load`, source commit
`a3b5c113112f77291d5f3d1360f33a882fdc52f7`. Local title and imported-scene
preview viewport/cleanup, ZIP directory-export and missing/corrupt-file handling.
Original source untouched; Godot contributor MIT notice in LICENSE.md.
Original assets, README attribution and font notice retained under godot.
Poly Haven chair is CC0 and Red Eclipse audio is CC BY-SA 4.0 per source README.
Inter OFL notice retained; Newsreader/Hack exact-binary attribution is documented
in FONT-AUDIT.md, including Hack's embedded full license notices.

## Status

- Import/runtime, 28 headless loading/submission checks and 20
  export/scene-state checks pass.
- FRICTIONAL.md also records bounded missing-file (30 checks) and corrupt-file
  (15 checks) diagnostics. These cover nonexistent paths and deliberately
  corrupt fixtures only, not permission failures, invalid export destinations or
  exhaustive parser fuzzing.
- Failure handling, visual fidelity and both native-4K Liam films remain pending.
- See FRICTIONAL.md for evidence and limitations.

Repository: https://github.com/nikbearbrown/walker-loading-runtime-save-load
