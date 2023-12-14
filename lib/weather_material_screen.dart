import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/api_key.dart';
import 'package:weather_app/hourly_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    String cityName = "London";

    try {
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey",
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw "An unexpeced error occurred";
      }

      setState(() {
        temp = data['list'][0]['main']['temp'];
      });
    } catch (e) {
      throw e.toString();
    }
  }

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
      body: temp == 0
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$temp K",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Icon(
                                  Icons.cloud,
                                  size: 50,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Rain",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // weather forecast cards
                  const Text(
                    "Weather Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyForecastItem(
                          time: "00:00",
                          icon: Icons.cloud,
                          temparature: "301.22",
                        ),
                        HourlyForecastItem(
                          time: "03:00",
                          icon: Icons.sunny,
                          temparature: "301.22",
                        ),
                        HourlyForecastItem(
                          time: "06:00",
                          icon: Icons.sunny,
                          temparature: "302.12",
                        ),
                        HourlyForecastItem(
                          time: "09:00",
                          icon: Icons.cloud,
                          temparature: "300.52",
                        ),
                      ],
                    ),
                  ),
                  // additional info
                  const SizedBox(height: 16),
                  const Text(
                    "Additional Info",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: "91",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: "7.5",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: "1000",
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
