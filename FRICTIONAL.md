# Verification and friction — 2026-09-24 10:23 UTC

Read original README, project, complete script/scene and bundled font license.
No source loading AGENTS.md found. Target was absent, no active Godot/ffmpeg worker.
Copied independently with root MIT license; changed only title, preserved assets.

Godot 4.7.2 headless import and 120-frame runtime completed cleanly (import and
runtime logs dated 20260924). `test_load.gd` fills the path field as diagnostic
setup, then sends actual click/Enter events through the viewport. It checks each
submission signal as well as resulting viewer/resource state. Final
load-edit-focus-fixed-20260924.log exits 0 with 28 passes: text equality, six image
formats, three fonts, three audio stream decodes and ZIP entry listing.

Initial load and load-input-fixed logs preserve diagnostic failures. Every second
Enter initially re-entered editing without submitting; merely grabbing focus
was insufficient. Clicking the field before Enter fixed the input sequence.
The first diagnostic also had stale-resource false positives, so explicit
submission-count assertions were added. Failed ZIP cleanup logged not-open;
final run opens and closes it cleanly. No runtime code fix was needed.

No audio playback/listening, image pixels, 3D scene, save/export or error handling
verified yet. NEXT test isolated local export round trips (unique new output
directory, never overwrite source/user files), ZIP previews, glTF and missing
files. Source inspection suggests loaded scene cleanup/placement needs checking.
Newsreader/Hack license-specific metadata still needs inspection; do not assume
the bundled Inter notice covers them. Both films pending existing visible-capture
constraint. No visible windows, uploads, paid services or approvals used.

## 11:08 UTC — isolated round trips and preview viewport fix

Added test_roundtrip.gd, inheriting the actual path-submit input checks. Export
handler calls are explicitly direct serialization diagnostics, not UI capture.
Each run gets its own mktemp directory under this project; no files overwritten
or deleted. Initial script parse error (inferred Variant comparison) retained in
roundtrip-20260924.log, corrected with explicit bool type.

roundtrip-repro-20260924.log reproduced two failures: ZIP export duplicates
directory records, and generated glTF nodes belong to the root viewport rather
than the preview camera's SubViewport. Local runtime fix now parents glTF/FBX
imports to that SubViewport and marks imported roots for cleanup without touching
the camera/lights. Final roundtrip-viewport-fixed-20260924.log confirms matching
viewport and freeing imported scene when switching to text. FBX untested.

Final diagnostic exits 1 with 15 passing assertions and the ZIP record comparison
still failing. Text bytes, PNG/WebP RGBA pixel bytes, JPG dimensions, ZIP opening,
glTF generation and scene cleanup pass. ZIP original has 8 entries; export has 12,
with each of four directory names duplicated. This is not a successful ZIP round
trip. Artifacts retained in roundtrip-A3QiUF and roundtrip-YvATdO.

NEXT diagnose ZIP directory handling; do not discard empty directories to make
the test pass. Then repeated scene loads, GLB export, error paths and font license
audit. No visible pixels or films verified. Existing capture blocker unchanged.

## 12:03 UTC — ZIP directories and GLB round trip

Consulted official Godot 4.7 ZIPPacker reference:
https://docs.godotengine.org/en/4.7/classes/class_zippacker.html
Directory entries now use add_directory in a first pass; only regular files use
start_file/write_file/close_file. This retains empty folders without duplicate
records. roundtrip-zip-fixed-20260924.log passes all 16 assertions; artifacts in
roundtrip-fbZkDF contain all eight original names and identical entry bytes.
Permissions/timestamps and archives with unusual ordering are not verified.

Expanded roundtrip-glb-20260924.log passes 20 assertions, exits 0 without script
errors. Exported chair.glb reloads with the same nonzero mesh-instance count,
replacing the old root frees it, and exactly one imported root remains beside
the camera/lights. Switching to text frees that root. Output directory
roundtrip-d22aTJ is retained. GLB reload is a direct handler diagnostic, not
captured UI interaction; material fidelity and rendered geometry are unverified.

NEXT missing/corrupt file error handling and font-specific license metadata.
Both films remain pending; no visible recording windows were opened.

## 12:33 UTC — missing-file recovery

Added input-driven test_errors.gd for six missing-file extensions. Reproduced
null audio stream get_length, invalid image, unopened ZIP and error views leaving
Export enabled. errors-repro-20260924.log retains six failed assertions and engine
errors. Local open_file now checks file existence before decoding; show_error
disables Export. Valid loads reset that disabled state normally.

errors-missing-fixed-20260924.log passes 30 checks (submission, error view, disabled
Export and valid-file recovery across PNG/Ogg/ZIP/text/TTF/glTF), exits 0 without
script/engine errors. load-regression-1233-20260924.log again passes all 28 loading
checks. This only addresses nonexistent paths, not corrupt existing media,
permission failures, races, or invalid export destinations. Those must not be
described as tested or repaired. Next: corrupt-file checks and font metadata audit.
Both films still pending the unchanged capture constraint.

## 13:03 UTC — corrupt-file recovery

Created isolated retained corrupt-NdyxEF fixtures by copying the supplied plain
text file to PNG/Ogg/ZIP/TTF/glTF suffixes. test_corrupt.gd calls the decoder
handler directly, then recovers via normal path-field click/Enter input.
corrupt-repro-20260924.log reproduces four error-view failures, including null
audio dereference and invalid fonts being applied merely because bytes existed.

Local guards now reject null/empty image, null audio stream, ZIP open failure,
and a font with zero faces. Existing glTF rejection already worked. Final
corrupt-guarded-20260924.log passes all 15 assertions and exits 0 without GDScript
exceptions. Expected native decoder ERROR diagnostics remain for deliberately
invalid content; this is NOT an error-free log or exhaustive parser fuzz test.
load-regression-1303-20260924.log passes all 28 valid-loading checks, exit 0.

Next: font-specific metadata/attribution audit. Export permission failures and
visual fidelity remain unverified. Both films pending existing capture constraint.

## 13:34 UTC — font provenance inspection

Recorded exact binary hashes and Newsreader name-table copyright/designer/version
and OFL declaration in FONT-AUDIT.md. The existing full OFL text remains intact.
Hack WOFF2 metadata remains unresolved: system FontTools lacks Brotli, bundled
Python lacks FontTools, and fc-scan returned no metadata. No dependency installs
or binary modifications attempted. Current official Hack license inspected as a
reference only; do not substitute its version attribution for local binary proof.
Continue that bounded audit before marking this item ready for capture; films
still pending the unchanged visible-capture constraint.

## 14:09 UTC — Hack exact-binary attribution resolved

Read-only audit_font_metadata.py uses existing Node zlib Brotli decoding with
existing system FontTools. No dependency installation or font writes. Execution
exited 0 and decoded Hack 3.003 release 3114f1256, Source Foundry/Bitstream
copyrights, complete embedded MIT/Bitstream notices and DejaVu declaration.
Both previously recorded hashes match. FONT-AUDIT.md records the evidence.

Bounded headless work is complete for now; proceed to the next feasible queue
item under the existing capture blocker. Preserve this item's both pending films,
visual/material checks and human review. This is not film completion or approval.
Export permission failures remain an untested edge case, not a claimed fix.
