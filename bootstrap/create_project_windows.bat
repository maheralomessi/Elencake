@echo off
set APP_DIR=EileenCakeApp
set ORG=com.eileencake.app
set NAME=eileen_cake_app

where flutter >nul 2>nul
if %errorlevel% neq 0 (
  echo Flutter غير مثبت أو غير موجود في PATH.
  exit /b 1
)

rmdir /s /q %APP_DIR% 2>nul
flutter create %APP_DIR% --org %ORG% --project-name %NAME%

xcopy /e /i /y app_content\lib %APP_DIR%\lib
xcopy /e /i /y app_content\assets %APP_DIR%\assets
copy /y app_content\pubspec.yaml %APP_DIR%\pubspec.yaml
copy /y app_content\analysis_options.yaml %APP_DIR%\analysis_options.yaml

cd %APP_DIR%
flutter pub get

echo ✅ تم إنشاء مشروع كامل داخل: %APP_DIR%
