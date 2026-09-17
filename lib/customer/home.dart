import 'package:flutter/material.dart';
import 'package:interview_demo_app/customer/orders.dart';
import 'package:interview_demo_app/customer/profile.dart';
import 'package:interview_demo_app/bottom_nav_bar.dart';
import 'package:interview_demo_app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<dynamic> _foodMenusData = [];
  int? foodMenuId;

  @override
  void initState() {
    super.initState();
    fetchFoodMenusDetails();
  }

  Future<void> fetchFoodMenusDetails() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/foodMenus'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    final data = jsonDecode(response.body);

    setState(() {
      _foodMenusData = data['food_menus'];
    });
  }

  Future<void> orderNow() async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/orderNow'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'food_menu_id': foodMenuId,}),
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHome(_foodMenusData),
      OrdersPage(token: ''),
      ProfilePage(token: ''),
    ];

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

  Widget _buildHome(dynamic foods) {
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
