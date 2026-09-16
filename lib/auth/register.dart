import 'package:flutter/material.dart';
import 'package:interview_demo_app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  const SizedBox(height: 40),

                  Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        InputFile(
                          label: "First Name",
                          controller: firstNameController,
                        ),
                        InputFile(
                          label: "Last Name",
                          controller: lastNameController,
                        ),
                        InputFile(
                          label: "Phone Number",
                          controller: phoneNumberController,
                        ),
                        InputFile(
                            label: "Email",
                            controller: emailController
                        ),
                        InputFile(
                          label: "Password",
                          controller: passwordController,
                          obscureText: true,
                        ),
                        InputFile(
                          label: "Confirm Password",
                          controller: confirmPasswordController,
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
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Already have an account? Login",
                            style: TextStyle(
                              color: Colors.blue,
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
      ),
    );
  }

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('${ApiConfig.baseUrl}/register');
    final body = json.encode({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'phoneNumber': phoneNumberController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'confirmPassword': confirmPasswordController.text,
    });

    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Success"),
            content: Text("Account created successfully"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Failed"),
            content: Text("Failed to register: ${response.body}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Error"),
          content: Text("Error: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class InputFile extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const InputFile({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 10),

        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        TextField(
          controller: controller,
          obscureText: obscureText,
          autocorrect: false,
          enableSuggestions: false,
          style: TextStyle(color: Colors.black87),
          decoration: decoration,
        ),
      ],
    );
  }
}
