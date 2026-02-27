import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  final double height;

  const BrandLogo({super.key, this.height = 34});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/branding/logo.png',
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Text(
          'Eileen Cake',
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}
