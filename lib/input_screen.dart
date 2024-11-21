import 'package:flutter/material.dart';
import 'workout_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  String goal = 'Fat Loss';
  int days = 6;
  Future<Map<String, dynamic>> fetchWorkoutPlan(String goal, int days) async {
    final url = Uri.parse('https://eec5-34-83-116-202.ngrok-free.app/workout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', 
        },
        body: json.encode({
          'input': 'generate $goal workout plan for $days days', 
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); 
      } else {
        throw Exception('Failed to fetch workout plan: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching workout plan: $error');
      throw Exception('Error fetching workout plan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Your Workout Plan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // goal 
                _buildInputCard(
                  child: DropdownButtonFormField<String>(
                    value: goal,
                    items: ['Fat Loss', 'Build Muscle', 'Body Recomposition']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => goal = value!),
                    decoration: const InputDecoration(
                      labelText: 'Goal',
                      border: InputBorder.none,
                      icon: Icon(Icons.flag),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // days
                _buildInputCard(
                  child: TextFormField(
                    initialValue: '3',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Days per week',
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        days = int.parse(value);
                      }
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Please enter a valid number of days.';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),


                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final plan = await fetchWorkoutPlan(goal, days);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutScreen(plan: plan),
                            ),
                          );
                        } catch (error) {
                          // Display error using SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error fetching plan: ${error.toString()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
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

  Widget _buildInputCard({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
