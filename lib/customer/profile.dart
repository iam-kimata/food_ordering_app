import 'package:flutter/material.dart';
import 'package:interview_demo_app/auth/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String fullName = "Aloyce Kimata";
  final String phoneNumber = "0784132299";
  final String email = "kimataaloyce44@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              fullName,
              Icons.person_outline,
            ),

            const SizedBox(height: 18),

            itemProfile(
              "Phone Number",
              phoneNumber,
              Icons.phone_outlined,
            ),

            const SizedBox(height: 18),

            itemProfile(
              "Email",
              email,
              Icons.mail_outline,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
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