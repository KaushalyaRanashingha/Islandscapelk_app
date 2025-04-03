import 'package:flutter/material.dart';

class RentCarPage extends StatelessWidget {
  // Example list of cars with dummy data
  final List<Map<String, String>> cars = [
    {
      "name": "Luxury Sedan",
      "location": "Dubai",
      "image": "assets/sedan.jpg",
      "price": "\$100/day",
    },
    {
      "name": "SUV",
      "location": "Paris",
      "image": "assets/suv.jpg",
      "price": "\$150/day",
    },
    {
      "name": "Convertible",
      "location": "Maldives",
      "image": "assets/convertible.jpg",
      "price": "\$200/day",
    },
    {
      "name": "Compact Car",
      "location": "New York",
      "image": "assets/compact.jpg",
      "price": "\$50/day",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rent a Car")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the car detail or booking page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailPage(car: car),
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
                        car["image"]!,
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
                            car["name"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            car["location"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            car["price"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
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

class CarDetailPage extends StatelessWidget {
  final Map<String, String> car;

  CarDetailPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car["name"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              car["image"]!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              car["name"]!,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              car["location"]!,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Add more details or description here
            const Text(
              "Rent this luxury car for an unforgettable experience. Comfortable, stylish, and perfect for your vacation!",
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
