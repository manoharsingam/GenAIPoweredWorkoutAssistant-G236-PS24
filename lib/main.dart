import 'package:flutter/material.dart';
import 'package:sapota_fit/input_screen_diet.dart';
import 'input_screen.dart';
import 'progress_tracker_page.dart'; 
import 'chatbot_screen.dart'; 
import 'userdetails.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GymApp());
}

class GymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserDetailsPage(),
      routes: {
        '/home': (context) => HomeScreen(), 
        '/progress': (context) => ProgressTrackerPage(),
        '/chatbot': (context) => ChatbotScreen(), 
        '/dietplan': (context) => InputScreendiet(plan: 'plan',), 


      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sapota Fit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              'Welcome to Sapota Fit!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            _buildOptionCard(
              context,
              title: 'Get Workout Split',
              subtitle: 'Generate a workout plan based on your fitness goal.',
              icon: Icons.fitness_center,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputScreen()),
                );
              },
            ),
            _buildOptionCard(
              context,
              title: 'Progress Tracker',
              subtitle: 'Track your fitness progress over time.',
              icon: Icons.trending_up,
              onPressed: () {
                Navigator.pushNamed(context, '/progress');
              },
            ),
            _buildOptionCard(
              context,
              title: 'ChatBot',
              subtitle: 'Ask our AI chatbot any fitness-related questions.',
              icon: Icons.chat,
              onPressed: () {
                Navigator.pushNamed(context, '/chatbot');
              },
            ),
          _buildOptionCard(
            context,
            title: 'Check Your Diet',
            subtitle: 'Get a personalized diet plan.',
            icon: Icons.restaurant_menu,
            onPressed: () {
              // Assuming you have the selected plan available here
              String selectedPlan = 'Fat loss';  // Replace with dynamic value from UserDetailsPage

              // Navigate to HomeScreen and pass the selected plan as an argument
              Navigator.pushNamed(
                context,
                '/dietplan',  // This is the route name for HomeScreen
                arguments: selectedPlan,  // Pass the selected plan as an argument
              );
            },
          ),


            _buildOptionCard(
              context,
              title: 'Correct your form',
              subtitle: 'Generate a workout plan based on your fitness goal.',
              icon: Icons.fitness_center,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputScreen()),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: onPressed,
      ),
    );
  }
}
 