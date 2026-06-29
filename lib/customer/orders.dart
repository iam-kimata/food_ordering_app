import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final List<Map<String, String>> foods = [
    { "name": "Burger", "description": "Juicy beef burger with cheese", "price": "8000", "dateTime": "27/06/2026 06:23" },
    { "name": "Pizza", "description": "Cheese pizza with toppings", "price": "12000", "dateTime": "04/05/2026 14:23" },
    { "name": "Chicken", "description": "Fried crispy chicken", "price": "10000", "dateTime": "05/07/2026 12:23" },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "Orders History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food["name"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(food["description"]!),

                  const SizedBox(height: 10),

                  Text(
                    "Tsh ${food["price"]!}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    food["dateTime"]!,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}