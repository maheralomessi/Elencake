import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../services/whatsapp_service.dart';
import '../../utils/format.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();

  String _payment = 'الدفع عند الاستلام';

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final cart = context.watch<CartProvider>();
    final items = cart.items(catalog);

    if (items.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('السلة فارغة.')),
      );
    }

    final total = cart.totalPrice(catalog);
    final wa = WhatsAppService(phoneInternational: catalog.business.whatsapp);

    return Scaffold(
      appBar: AppBar(title: const Text('إتمام الطلب')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ملخص الطلب', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  ...items.map((it) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${it.product.name} × ${it.quantity}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(Format.price(it.total)),
                        ],
                      ),
                    );
                  }),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Expanded(child: Text('الإجمالي')),
                      Text(
                        Format.price(total),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('بيانات العميل', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'الاسم',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'اكتب الاسم'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'رقم التواصل',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (v) => (v == null || v.trim().length < 7)
                          ? 'اكتب رقم صحيح'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _address,
                      decoration: const InputDecoration(
                        labelText: 'العنوان',
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'اكتب العنوان'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _payment,
                      items: const [
                        DropdownMenuItem(
                          value: 'الدفع عند الاستلام',
                          child: Text('الدفع عند الاستلام'),
                        ),
                        DropdownMenuItem(
                          value: 'تحويل بنك الكريمي',
                          child: Text('تحويل بنك الكريمي'),
                        ),
                        DropdownMenuItem(
                          value: 'محفظة جيب',
                          child: Text('محفظة جيب'),
                        ),
                      ],
                      onChanged: (v) => setState(() => _payment = v ?? _payment),
                      decoration: const InputDecoration(
                        labelText: 'طريقة الدفع',
                        prefixIcon: Icon(Icons.payments_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _notes,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'ملاحظات (اختياري)',
                        prefixIcon: Icon(Icons.notes_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton.icon(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;

              final lineItems = items
                  .map((it) => {
                        'name': it.product.name,
                        'qty': it.quantity,
                        'lineTotal': Format.price(it.total),
                      })
                  .toList();

              final msg = wa.buildOrderMessage(
                businessName: catalog.business.nameArabic,
                customerName: _name.text.trim(),
                customerPhone: _phone.text.trim(),
                customerAddress: _address.text.trim(),
                paymentMethod: _payment,
                notes: _notes.text.trim(),
                items: lineItems,
                totalText: Format.price(total),
              );

              await wa.openChat(message: msg);
              cart.clear();
              if (!mounted) return;
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('إرسال الطلب عبر واتساب'),
          ),
        ),
      ),
    );
  }
}
