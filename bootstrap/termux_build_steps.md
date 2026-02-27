# بناء APK على أندرويد عبر Termux (مختصر)

> ملاحظة: تثبيت Flutter على Termux قد يأخذ وقت ومساحة.

1) ثبّت المتطلبات:
```bash
pkg update && pkg upgrade -y
pkg install git wget unzip clang cmake ninja -y
```

2) تنزيل Flutter:
```bash
cd ~
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$HOME/flutter/bin:$PATH"
flutter doctor
```

3) أنشئ المشروع من هذا الباندل:
```bash
cd /sdcard/Download/اسم_المجلد_بعد_فك_الضغط
bash bootstrap/create_project.sh
```

4) بناء APK:
```bash
cd EileenCakeApp
flutter build apk --release
```

سيكون الـ APK في:
`build/app/outputs/flutter-apk/app-release.apk`
