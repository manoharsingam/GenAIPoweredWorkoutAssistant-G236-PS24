import 'package:flutter/material.dart';
import 'package:sapota_fit/cv_model_screen.dart';
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
        '/dietplan': (context) => InputScreendiet(plan: 'plan'),
        '/cvmodel': (context) => CVModelScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
  title: const Text('Sapota Fit'),
  centerTitle: true,
  backgroundColor: const Color.fromARGB(255, 136, 126, 154), 
),
body: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 52, 234, 64), 
        const Color.fromARGB(255, 161, 212, 235), 
      ], 
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),


        child: Padding(
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
                  color: Colors.white, // White text for the title
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Adding options with cards
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
                  String selectedPlan = 'Fat loss';

                  Navigator.pushNamed(
                    context,
                    '/dietplan',
                    arguments: selectedPlan,
                  );
                },
              ),
              _buildOptionCard(
                context,
                title: 'Real-Time Object Monitoring',
                subtitle: 'Monitor objects using a live camera feed.',
                icon: Icons.camera,
                onPressed: () {
                  Navigator.pushNamed(context, '/cvmodel');
                },
              ),
            ],
          ),
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
      elevation: 8, // Increased elevation for shadow effect
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.deepPurple),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
        onTap: onPressed,
      ),
    );
  }
}
