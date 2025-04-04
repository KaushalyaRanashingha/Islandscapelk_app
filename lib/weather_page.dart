import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecasting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _weatherData = '';
  bool _isLoading = false;
  String _weatherCondition = '';
  List<Map<String, String>> _forecastList = [];

  final String apiKey = '512938f948d6f1d5e00ca03f40600462';

  Future<void> _fetchWeather(String location) async {
    setState(() {
      _isLoading = true;
      _forecastList = [];
    });

    try {
      final weatherResponse = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey'));

      final forecastResponse = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey'));

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        final weatherData = json.decode(weatherResponse.body);
        final forecastData = json.decode(forecastResponse.body);

        String description = weatherData['weather'][0]['description'];
        double tempKelvin = weatherData['main']['temp'];
        double tempCelsius = tempKelvin - 273.15;

        List forecastList = forecastData['list'];
        List<Map<String, String>> filteredForecast = [];

        for (var item in forecastList) {
          String dateTime = item['dt_txt'];
          if (dateTime.contains('12:00:00')) {
            String desc = item['weather'][0]['main'];
            double temp = item['main']['temp'] - 273.15;
            filteredForecast.add({
              'date': dateTime.split(' ')[0],
              'desc': desc,
              'temp': '${temp.toStringAsFixed(1)}°C'
            });
          }
        }

        setState(() {
          _weatherData =
              '$description\nTemperature: ${tempCelsius.toStringAsFixed(1)}°C';
          _weatherCondition = description.toLowerCase();
          _forecastList = filteredForecast;
          _isLoading = false;
        });
      } else {
        setState(() {
          _weatherData = 'Error fetching weather data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  String _getAnimationForWeather() {
    if (_weatherCondition.contains('rain')) {
      return 'assets/animations/rain.json';
    } else if (_weatherCondition.contains('cloud')) {
      return 'assets/animations/cloudy.json';
    } else if (_weatherCondition.contains('clear')) {
      return 'assets/animations/sunny.json';
    } else if (_weatherCondition.contains('snow')) {
      return 'assets/animations/snow.json';
    } else {
      return 'assets/animations/search.json';
    }
  }

  void _shareWeather() {
    if (_weatherData.isNotEmpty) {
      String message = "🌤 Weather Update 🌤\n\n$_weatherData";

      if (_forecastList.isNotEmpty) {
        message += "\n\n📅 5-Day Forecast:";
        for (var item in _forecastList) {
          message += "\n📍 ${item['date']} - ${item['desc']} (${item['temp']})";
        }
      }

      Share.share(message); // Trigger share dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset('assets/log111.png'),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Navigate or do something
              },
            ),
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text('Weather'),
              onTap: () {
                Navigator.pop(context);
                // Already here, or navigate to another weather screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings page
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Rent a Car'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Rent a Car screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text('Book Hotel'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Book Hotel screen
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter Location',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon:
                        const Icon(Icons.location_on, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.blue),
                      onPressed: () {
                        _fetchWeather(_controller.text);
                        FocusScope.of(context).unfocus(); // dismiss keyboard
                      },
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Column(
                  children: [
                    Lottie.asset(
                      _getAnimationForWeather(),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _weatherData.isNotEmpty
                          ? _weatherData
                          : 'Enter a location to get weather updates',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (_forecastList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '5-Day Forecast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (_forecastList.isNotEmpty)
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _forecastList.length,
                          itemBuilder: (context, index) {
                            final item = _forecastList[index];
                            return Container(
                              width: 120,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['date'] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(item['desc'] ?? ''),
                                  const SizedBox(height: 5),
                                  Text(item['temp'] ?? ''),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shareWeather,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.share, color: Colors.white),
      ),
    );
  }
}
