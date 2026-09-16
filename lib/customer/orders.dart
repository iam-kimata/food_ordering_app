import 'package:flutter/material.dart';
import 'package:interview_demo_app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  final String token;
  const OrdersPage({super.key, required this.token});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<dynamic> _orderHistoryDetails = [];

  @override
  void initState() {
    super.initState();
    fetchOrderHistoryDetails();
  }

  Future<void> fetchOrderHistoryDetails() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/orderHistoryDetails'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    final data = jsonDecode(response.body);

    setState(() {
      _orderHistoryDetails = data['orders_menus'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: _orderHistoryDetails.length,
        itemBuilder: (context, index) {
          final food = _orderHistoryDetails[index];
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