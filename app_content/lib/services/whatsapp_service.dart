
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  final String phoneInternational;

  const WhatsAppService({required this.phoneInternational});

  Future<void> openChat({String? message}) async {
    final encoded = message == null || message.trim().isEmpty
        ? ''
        : '?text=${Uri.encodeComponent(message)}';

    // Prefer wa.me
    final uri = Uri.parse('https://wa.me/$phoneInternational$encoded');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Fallback for some devices
      final fallback = Uri.parse('https://api.whatsapp.com/send?phone=$phoneInternational&text=${Uri.encodeComponent(message ?? '')}');
      await launchUrl(fallback, mode: LaunchMode.externalApplication);
    }
  }

  String buildOrderMessage({
    required String businessName,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String paymentMethod,
    required String notes,
    required List<Map<String, dynamic>> items,
    required String totalText,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('طلب جديد - $businessName');
    buffer.writeln('--------------------------------');
    buffer.writeln('الاسم: $customerName');
    buffer.writeln('رقم التواصل: $customerPhone');
    buffer.writeln('العنوان: $customerAddress');
    buffer.writeln('طريقة الدفع: $paymentMethod');
    if (notes.trim().isNotEmpty) buffer.writeln('ملاحظات: $notes');
    buffer.writeln('--------------------------------');
    buffer.writeln('الطلب:');
    for (final it in items) {
      buffer.writeln('- ${it['name']} × ${it['qty']} = ${it['lineTotal']}');
    }
    buffer.writeln('--------------------------------');
    buffer.writeln('الإجمالي: $totalText');
    buffer.writeln('');
    buffer.writeln('تم الإرسال عبر تطبيق Eileen Cake ✅');
    return buffer.toString();
  }
}
