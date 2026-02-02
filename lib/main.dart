// main.dart
import 'package:flutter/material.dart';

// The main entry point of the app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TASK 1: Change the title of the app
      title: 'My Awerson app',
      theme: ThemeData(
        // TASK 2: Change the primary swatch color (try Colors.red, Colors.green)
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TASK 3: Change the text in the top bar
        title: Text('Welcome to my app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TASK 4: Change the main text below
            Text(
              'Welcome to my app ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Adds space between widgets
            // TASK 5: Change the subtitle text
            Text(
              "Lets learn Flutter togther ",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Button Clicked!');
              },
              // TASK 6: Change the text on the button
              child: Text('Press HEre'),
            ),
          ],
        ),
      ),
    );
  }
}