import 'package:flutter/material.dart';
import 'package:interview_demo_app/auth/login.dart';
import 'package:interview_demo_app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String token;
  const ProfilePage({super.key, required this.token});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();

    _fetchUserData().then((data) {
      setState(() {
        userData = data;
      });
    });
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final token = widget.token;
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/user/information'),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> _logout() async {
    final token = widget.token;
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/logout'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to logout')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(22),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage:AssetImage('lib/images/profile.png'),
                  ),

                  SizedBox(height: 15),

                ],
              ),
            ),

            const SizedBox(height: 30),

            itemProfile(
              "Full Name",
              userData['fullName'],
              Icons.person_outline,
            ),

            const SizedBox(height: 18),

            itemProfile(
              "Phone Number",
              userData['phoneNumber'],
              Icons.phone_outlined,
            ),

            const SizedBox(height: 18),

            itemProfile(
              "Email",
              userData['email'],
              Icons.mail_outline,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          color: Colors.blue,
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}