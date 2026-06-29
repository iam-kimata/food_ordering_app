import 'package:flutter/material.dart';
import 'package:interview_demo_app/auth/register.dart';
import 'package:interview_demo_app/customer/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                const SizedBox(height: 40),

                Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: usernameController,
                        hintText: "Email",
                        obscureText: false,
                      ),

                      const SizedBox(height: 15),

                      CustomTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          "Don't have an account? Register",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      autocorrect: false,
      enableSuggestions: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}