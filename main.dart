import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Info Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeDashboard(),
    );
  }
}

class StudentCounter extends StatefulWidget {
  @override
  _StudentCounterState createState() => _StudentCounterState();
}

class _StudentCounterState extends State<StudentCounter> {
  int _studentCount = 0;

  void _incrementCounter() {
    setState(() {
      _studentCount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_studentCount > 0) {
        _studentCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Student Count:',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '$_studentCount',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('+'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: _decrementCounter,
              child: Text('-'),
            ),
          ],
        ),
      ],
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = 'me.com';
  String _password = '12345';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Process the login (e.g., send to an API)
                  print('Email: $_email, Password: $_password');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login Successful!')),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}




class WelcomeDashboard extends StatelessWidget {
  final String imageUrl = 'https://via.placeholder.com/150'; // Replace with a real image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info Manager'),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to prevent overflow
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your Name: [Your Name]',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  'Course: [Your Course]',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  'University: [Your University]',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hello, [Your Name]! Welcome to the Student Info Manager.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  child: Text('Show Alert'),
                ),
                SizedBox(height: 20),
                StudentCounter(),
                SizedBox(height: 20),
                LoginForm(),
                SizedBox(height: 20),
                // Profile Picture Display
                Container(
                  width: 150, // Set a fixed width
                  height: 150, // Set a fixed height
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75), // Make it circular
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover, // Cover the container
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Text('Failed to load image');
                      },
                    ),
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




