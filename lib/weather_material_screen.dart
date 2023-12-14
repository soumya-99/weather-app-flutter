import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("Refresh...");
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: const Column(
        children: [
          // main card
          Placeholder(
            fallbackHeight: 250,
          ),
          SizedBox(height: 20),
          // weather forecast cards
          Placeholder(
            fallbackHeight: 150,
          ),
          SizedBox(height: 20),
          // additional info
          Placeholder(
            fallbackHeight: 150,
          ),
        ],
      ),
    );
  }
}
