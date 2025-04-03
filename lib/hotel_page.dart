import 'package:flutter/material.dart';

class HotelPage extends StatelessWidget {
  // Example list of hotels with dummy data
  final List<Map<String, String>> hotels = [
    {
      "name": "Luxury Resort",
      "location": "Maldives",
      "image": "assets/maldives.jpg",
      "rating": "5.0",
    },
    {
      "name": "Skyline Hotel",
      "location": "Dubai",
      "image": "assets/dubai.jpg",
      "rating": "4.8",
    },
    {
      "name": "Ocean View Hotel",
      "location": "Santorini",
      "image": "assets/santorini.jpg",
      "rating": "4.7",
    },
    {
      "name": "Parisian Luxury",
      "location": "Paris",
      "image": "assets/paris.jpg",
      "rating": "4.9",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hotels")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the hotel detail page or booking page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailPage(hotel: hotel),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        hotel["image"]!,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel["name"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            hotel["location"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                hotel["rating"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HotelDetailPage extends StatelessWidget {
  final Map<String, String> hotel;

  HotelDetailPage({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotel["name"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              hotel["image"]!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              hotel["name"]!,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              hotel["location"]!,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Add more details or description here
            const Text(
              "This luxurious hotel offers exceptional amenities including spas, fine dining, and a breathtaking view. Perfect for your next vacation!",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Add a booking button or additional actions
            ElevatedButton(
              onPressed: () {
                // Navigate to the booking page or functionality
              },
              child: const Text("Book Now"),
            ),
          ],
        ),
      ),
    );
  }
}
