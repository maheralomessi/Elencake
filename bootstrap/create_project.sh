#!/usr/bin/env bash
set -euo pipefail

APP_DIR="EileenCakeApp"
ORG="com.eileencake.app"
NAME="eileen_cake_app"

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter غير مثبت أو غير موجود في PATH. ثبّت Flutter ثم أعد المحاولة." >&2
  exit 1
fi

# Create clean project
rm -rf "$APP_DIR"
flutter create "$APP_DIR" --org "$ORG" --project-name "$NAME" >/dev/null

# Copy app content
cp -r app_content/lib "$APP_DIR/"
cp -r app_content/assets "$APP_DIR/"
cp app_content/pubspec.yaml "$APP_DIR/pubspec.yaml"
cp app_content/analysis_options.yaml "$APP_DIR/analysis_options.yaml" || true

cd "$APP_DIR"
flutter pub get

echo "✅ تم إنشاء مشروع كامل داخل: $APP_DIR"
