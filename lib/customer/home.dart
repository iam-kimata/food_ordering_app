import 'package:flutter/material.dart';
import 'package:interview_demo_app/customer/orders.dart';
import 'package:interview_demo_app/customer/profile.dart';
import 'package:interview_demo_app/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> foods = [
    { "name": "Burger", "description": "Juicy beef burger with cheese", "price": "8000" },
    { "name": "Pizza", "description": "Cheese pizza with toppings", "price": "12000" },
    { "name": "Chicken", "description": "Fried crispy chicken", "price": "10000" },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [_buildHome(), OrdersPage(), ProfilePage()];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          _currentIndex == 0
              ? 'Enjoy Our Food Menus'
              : _currentIndex == 1
              ? 'Orders History'
              : 'Account Information',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHome() {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food["name"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(food["description"]!),

                const SizedBox(height: 10),

                Text(
                  "Tsh ${food["price"]!}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Order Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
