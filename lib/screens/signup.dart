import 'package:flutter/material.dart';
import 'package:lostfound/screens/dashboard.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword= true;
  bool _obscureCofrimPass = true;
  bool _isLoading = false;

  TextEditingController _fullName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  String _enteredPassword = '';

  void _submitRegistration(BuildContext context) async {
    if (!_formKey.currentState!.validate() || _isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Account Created successfully')),
      );

      String enteredFullname = _fullName.text;
      String enteredPassword = _password.text;
      String enteredEmail = _email.text;
      String enteredPhone = _phone.text;

      _fullName.clear();
      _password.clear();
      _email.clear();
      _phone.clear();
      _confirmPassword.clear();
      _enteredPassword = '';

      await Future.delayed(const Duration(milliseconds: 500));

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(enteredFullname)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validPhoneNbr(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    final phone = value.replaceAll(RegExp(r'[^\d]'), '');

    if (phone.length != 11) {
      return 'Phone must be 11 digits (03XX-XXXXXXX)';
    }

    if (!phone.startsWith('03')) {
      return 'Must start with 03';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (value.length > 32) {
      return 'Password cannot exceed 32 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter (A-Z)';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter (a-z)';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number (0-9)';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain a special character (!@#\$%^&*)';
    }

    // Optional: Check for common weak passwords
    final weakPasswords = ['password', '12345678', 'qwertyui', 'admin123'];
    if (weakPasswords.contains(value.toLowerCase())) {
      return 'Please choose a stronger password';
    }
    _enteredPassword = value;

    return null; // Valid
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _enteredPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 90),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ).createShader(bounds),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 30),
              SizedBox(
                height: 100,
                width: double.infinity,

                child: const CircleAvatar(
                  radius: 80,
                  child: Image(image: AssetImage('resources/images/logo4.png')),
                ),
              ),
              const SizedBox(height: 50),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullName,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        hintText: "Enter FullName",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter a FullName';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _email,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        prefixIcon: const Icon(Icons.email_rounded),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _phone,
                      validator: validPhoneNbr,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        hintText: "Enter Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),

                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscurePassword,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPassword,
                      obscureText: _obscureCofrimPass,
                      validator: validateConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Enter Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureCofrimPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureCofrimPass = !_obscureCofrimPass;
                            });
                          },
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _submitRegistration(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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
    );
  }
}
