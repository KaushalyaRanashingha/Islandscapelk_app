import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPage createState() => _WeatherPage();
}

class _WeatherPage extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  String _city = '';
  String _temperature = '';
  String _weatherDescription = '';

  // Example data for display. Replace with actual API data.
  void _getWeather() {
    setState(() {
      // Here you would integrate an API to fetch actual weather data
      _city = _cityController.text;
      _temperature = '25°C'; // Dummy temperature
      _weatherDescription = 'Clear Sky'; // Dummy weather description
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // City input field
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _getWeather(),
            ),
            const SizedBox(height: 20),
            // Button to fetch weather
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            // Weather data display
            if (_city.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Weather in $_city',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Temperature: $_temperature',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Description: $_weatherDescription',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            else
              const Text(
                'Enter a city to get the weather.',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
