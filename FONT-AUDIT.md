# Font attribution audit — 2026-09-24

All original font binaries and bundled LICENSE.txt are preserved unmodified.

## Newsreader

FontTools decoded the local TTF name table:

- File: godot/examples/fonts/newsreader_9pt_regular.ttf
- SHA256: 2d1317e61d846bec2df9472471bc2a24aa2327fd7917e364f36b7986ec9c5ee8
- Family/version: Newsreader 9pt, Version 1.003
- Copyright 2020 The Newsreader Project Authors (http://github.com/productiontype/Newsreader)
- Manufacturer: Production Type; designer: Hugues Gentile.
- Embedded license declaration: SIL Open Font License 1.1.

The complete OFL 1.1 text is already retained in godot/examples/fonts/LICENSE.txt;
its opening attribution is Inter-specific, not Newsreader's. This document records
the Newsreader-specific attribution alongside that unchanged license text.

## Hack — exact binary attribution verified at 14:09 UTC

- File: godot/examples/fonts/hack_regular.woff2
- SHA256: b89559de66dbc62daa8ff8664ef5c27c87c1263916e0ec8d2fc09ccf270fd3c4
- Local FontTools cannot decode WOFF2 because its Brotli Python extension is absent.
- Bundled runtime Python has no FontTools. fc-scan returned no Hack metadata.
- No dependencies installed or font files rewritten during the audit.

[Current upstream license](https://raw.githubusercontent.com/source-foundry/Hack/master/LICENSE.md)
identifies Source Foundry MIT terms, DejaVu public-domain work and Bitstream Vera
terms. This is reference evidence, not proof of which Hack revision this binary
contains. Do not attribute it to Inter's OFL or call the exact-binary audit complete.

The earlier decoding limitation was resolved without installing packages:
audit_font_metadata.py supplies installed Node's standard Brotli decoder to the
existing FontTools reader. It reads bytes only and writes no font files.

Decoded name table for the hash above:

- Family: Hack; manufacturer: Source Foundry; designer: Source Foundry Authors.
- Version: 3.003; release identifier 3114f1256.
- Copyright (c) 2018 Source Foundry Authors / Copyright (c) 2003 by Bitstream, Inc. All Rights Reserved.
- Name ID 13 contains the complete MIT and Bitstream Vera license texts plus the
  DejaVu public-domain declaration, retained in the unchanged original binary.
- Name ID 14 identifies https://github.com/source-foundry/Hack/blob/master/LICENSE.md.

The exact-binary attribution gap is now resolved. The script reproducibly prints
all retained notices and both font hashes. No distribution or publication performed.
