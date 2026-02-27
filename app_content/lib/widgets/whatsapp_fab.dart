import 'package:flutter/material.dart';

import '../services/whatsapp_service.dart';

class WhatsAppFab extends StatelessWidget {
  final WhatsAppService service;
  final String? message;

  const WhatsAppFab({super.key, required this.service, this.message});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => service.openChat(message: message),
      icon: const Icon(Icons.chat_bubble_outline),
      label: const Text('واتساب'),
    );
  }
}
