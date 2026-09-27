"""Read font name tables without changing font files or installing packages.

System FontTools lacks its optional Python Brotli decoder. Use installed Node's
standard zlib Brotli decoder for the read-only WOFF2 decoding operation.
"""
import hashlib
import subprocess
import sys
import types
from pathlib import Path

node = "/Users/bear/.nvm/versions/node/v24.17.0/bin/node"
decoder = types.ModuleType("brotli")


def decompress(data):
    return subprocess.run(
        [node, "-e", "process.stdout.write(require('node:zlib').brotliDecompressSync(require('node:fs').readFileSync(0)))"],
        input=data, capture_output=True, check=True,
    ).stdout


decoder.decompress = decompress
sys.modules["brotli"] = decoder
from fontTools.ttLib import TTFont

for name in ["newsreader_9pt_regular.ttf", "hack_regular.woff2"]:
    path = Path(__file__).parent / "godot/examples/fonts" / name
    print("FILE", name, "SHA256", hashlib.sha256(path.read_bytes()).hexdigest())
    with TTFont(path) as font:
        for name_id in [0, 1, 5, 8, 9, 13, 14]:
            print(name_id, sorted({r.toUnicode() for r in font["name"].names if r.nameID == name_id}))
