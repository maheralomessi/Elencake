import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/catalog_provider.dart';
import '../../services/whatsapp_service.dart';
import '../../widgets/brand_logo.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final business = context.watch<CatalogProvider>().business;
    final wa = WhatsAppService(phoneInternational: business.whatsapp);

    return Scaffold(
      appBar: AppBar(title: const Text('معلومات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const BrandLogo(height: 70),
                const SizedBox(height: 10),
                Text(business.nameArabic,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  business.slogan,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('التواصل'),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.phone_in_talk_outlined),
                    title: Text(business.phoneDisplay),
                    subtitle: const Text('واتساب / اتصال'),
                    onTap: () => wa.openChat(
                      message: 'السلام عليكم، أريد الاستفسار عن الطلب.',
                    ),
                  ),
                  const Divider(height: 22),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('العنوان'),
                    subtitle: Text(business.address),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('مجلد الصور داخل المشروع'),
                  SizedBox(height: 10),
                  Text(
                    '• الشعار: assets/images/branding/logo.png\n'
                    '• صور المنتجات: assets/images/products/\n'
                    '• صور الأقسام: assets/images/categories/\n'
                    '• بنرات العروض: assets/images/promos/',
                    style: TextStyle(color: Colors.black54, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('طرق الدفع'),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.account_balance_outlined),
                    title: Text(business.kuraimiName),
                    subtitle: Text('رقم الحساب: ${business.kuraimiAccount}'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.wallet_outlined),
                    title: Text(business.jeebName),
                    subtitle: Text('الرقم: ${business.jeebNumber}'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('روابط السوشال'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => launchUrl(
                          Uri.parse(business.facebook),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: const Icon(Icons.facebook),
                        label: const Text('Facebook'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => launchUrl(
                          Uri.parse(business.instagram),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Instagram'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
