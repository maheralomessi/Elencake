# مشروع تطبيق ايلين كيك (Flutter) — النسخة الكاملة

هذا الملف يحتوي **محتوى التطبيق بالكامل** (واجهات Flutter + بيانات + صور) مع سكربت يقوم بإنشاء مشروع Flutter كامل (android/ios/web) تلقائياً على جهازك.

> السبب: إنشاء ملفات Android/iOS الرسمية يحتاج وجود Flutter SDK لديك. لذلك أرفقت سكربت يجهّز المشروع كاملاً بضغطة واحدة.

---

## 1) إنشاء مشروع Flutter كامل تلقائياً

### على الكمبيوتر أو Termux (Linux/Android)
1. تأكد أن Flutter مثبت ويعمل:
   ```bash
   flutter --version
   ```
2. فك الضغط عن هذا الملف.
3. نفّذ السكربت:
   ```bash
   bash bootstrap/create_project.sh
   ```

سينتج مجلد جديد اسمه:
`EileenCakeApp/`

وهو مشروع Flutter كامل جاهز للتشغيل.

### على Windows
افتح CMD داخل مجلد الملف بعد فك الضغط ثم:
```bat
bootstrap\create_project_windows.bat
```

---

## 2) تشغيل التطبيق
داخل مجلد `EileenCakeApp`:
```bash
flutter pub get
flutter run
```

---

## 3) بناء APK للتثبيت على الهاتف
داخل مجلد `EileenCakeApp`:
```bash
flutter build apk --release
```
ستجد الملف هنا:
`EileenCakeApp/build/app/outputs/flutter-apk/app-release.apk`

---

## 4) أين تضع صور الشعار والمنتجات؟
كل الصور داخل:
`EileenCakeApp/assets/images/`

### الشعار
ضع شعارك هنا (استبدل الملف الحالي بنفس الاسم):
`assets/images/branding/logo.png`

### صور المنتجات
ضع صور المنتجات هنا:
`assets/images/products/`

> داخل المشروع أضفت أسماء ملفات جاهزة (placeholder) لكي تستبدلها أنت بسهولة بنفس الاسم.

أهم الملفات الجاهزة للاستبدال:
- `assets/images/products/cake_30.jpg`
- `assets/images/products/cupcake_promo.jpg`
- `assets/images/products/wedding_cake.jpg`
- `assets/images/products/desserts_box.jpg`
- `assets/images/products/pizza.jpg`
- `assets/images/products/home_of_glory.jpg`
- `assets/images/products/quote_chocolate.jpg`
- `assets/images/products/birthday_itismy.jpg`
- `assets/images/products/perfume_dessert.jpg`

### تعديل المنتجات (الأسماء/الأسعار/الصور)
من الملف:
`assets/data/catalog.json`

كل منتج فيه حقل:
```json
"image": "assets/images/products/اسم_الصورة.jpg"
```

---

## 5) تعديل بيانات المحل (واتساب/العنوان/طرق الدفع)
من الملف:
`assets/data/business.json`

عدّل:
- `whatsapp` (يفضل بصيغة دولية مثال: 9677xxxxxxx)
- `phoneDisplay`
- `address`
- `payment`

