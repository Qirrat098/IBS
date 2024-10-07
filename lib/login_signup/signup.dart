import 'package:flutter/material.dart';
import 'login.dart';  // Ensure that this import points to your login screen file

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _confirmObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Top-left corner background image
          Positioned(
            top: MediaQuery.of(context).size.width * 0.1,
            left: MediaQuery.of(context).size.width * 0.7 - 100,
            child: Image.asset(
              'assets/images/bg3.png',
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
          ),
          // Bottom-right corner background image
          Positioned(
            bottom: MediaQuery.of(context).size.width * -0.08,
            right: MediaQuery.of(context).size.width * 0.30,
            child: Image.asset(
              'assets/images/bg5.png',
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333452),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Color(0xFF333452), fontSize: 14),
                          prefixIcon: Icon(Icons.email, color: Colors.deepPurple , size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.width * 0.12,
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0),
                      child: TextFormField(
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Color(0xFF333452), fontSize: 14),
                          prefixIcon: Icon(Icons.lock, color: Colors.deepPurple , size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.deepPurple, size: 20
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.width * 0.12,
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0),
                      child: TextFormField(
                        obscureText: _confirmObscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Re-enter your Password',
                          hintStyle: TextStyle(color: Color(0xFF333452), fontSize: 14),
                          prefixIcon: Icon(Icons.lock, color: Colors.deepPurple , size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmObscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.deepPurple, size: 20
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmObscurePassword = !_confirmObscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.width * 0.12,
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 26),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.purple,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Navigate to the next page or show confirmation
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.8,
                            MediaQuery.of(context).size.width * 0.1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.040,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(color: Colors.deepPurple),
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
        ],
      ),
    );
  }
}
