import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final String label;

  const WeatherCard({super.key, this.title = "", this.label = ""});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: CardTheme.of(context).shape,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(label,style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
