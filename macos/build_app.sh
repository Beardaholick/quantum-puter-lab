#!/bin/bash
# Build ~/QuantumPuter/dist/Quantum Puter Lab.app from the PWA tree.
set -e
SRC="${1:-}"
if [ -z "$SRC" ]; then
  SRC="$(cd "$(dirname "$0")/.." && pwd)"
fi
DEST_DIR="${2:-$HOME/QuantumPuter/dist}"
APP="$DEST_DIR/Quantum Puter Lab.app"

# also publish a working copy at ~/QuantumPuter/app
APPCOPY="${3:-$HOME/QuantumPuter/app}"

echo "source $SRC"
echo "app    $APP"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources/www"

# www (exclude macos packager, .git)
/usr/bin/python3 - "$SRC" "$APP/Contents/Resources/www" << 'PY'
import os, shutil, sys
src, dest = sys.argv[1], sys.argv[2]
skip = {'.git', 'macos', '.github', '__pycache__'}
def ignore(dir, names):
    return [n for n in names if n in skip or n.endswith('.pyc') or n == '.DS_Store']
# dest already exists; copy contents
for name in os.listdir(src):
    if name in skip or name == '.DS_Store':
        continue
    s=os.path.join(src,name); d=os.path.join(dest,name)
    if os.path.isdir(s):
        shutil.copytree(s,d, ignore=ignore)
    else:
        shutil.copy2(s,d)
print("www copied")
PY

cp "$SRC/macos/launcher" "$APP/Contents/MacOS/launcher"
chmod +x "$APP/Contents/MacOS/launcher"
cp "$SRC/macos/Info.plist" "$APP/Contents/Info.plist"

# icns
ICONSET="$DEST_DIR/AppIcon.iconset"
rm -rf "$ICONSET"
mkdir -p "$ICONSET"
ICONS="$SRC/icons"
cp "$ICONS/icon-32.png"   "$ICONSET/icon_16x16@2x.png"
cp "$ICONS/icon-32.png"   "$ICONSET/icon_32x32.png"
cp "$ICONS/icon-64.png"   "$ICONSET/icon_32x32@2x.png"
cp "$ICONS/icon-128.png"  "$ICONSET/icon_128x128.png"
cp "$ICONS/icon-256.png"  "$ICONSET/icon_128x128@2x.png"
cp "$ICONS/icon-256.png"  "$ICONSET/icon_256x256.png"
cp "$ICONS/icon-512.png"  "$ICONSET/icon_256x256@2x.png"
cp "$ICONS/icon-512.png"  "$ICONSET/icon_512x512.png"
cp "$ICONS/icon-1024.png" "$ICONSET/icon_512x512@2x.png"
# 16px
sips -z 16 16 "$ICONS/icon-32.png" --out "$ICONSET/icon_16x16.png" >/dev/null
iconutil -c icns -o "$APP/Contents/Resources/AppIcon.icns" "$ICONSET"
rm -rf "$ICONSET"

# working copy
rm -rf "$APPCOPY"
/usr/bin/python3 - "$SRC" "$APPCOPY" << 'PY'
import os, shutil, sys
src, dest = sys.argv[1], sys.argv[2]
skip = {'.git', '__pycache__'}
def ignore(dir, names):
    return [n for n in names if n in skip or n.endswith('.pyc') or n == '.DS_Store']
shutil.copytree(src, dest, ignore=ignore)
print("app copy", dest)
PY
chmod +x "$APPCOPY/serve.py" "$APPCOPY/macos/build_app.sh" "$APPCOPY/macos/launcher"

# touch the bundle so Finder picks up the icon
touch "$APP"
echo "built $APP"
ls -la "$APP/Contents/MacOS" "$APP/Contents/Resources/AppIcon.icns"
