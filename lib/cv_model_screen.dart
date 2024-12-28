import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CVModelScreen extends StatefulWidget {
  @override
  _CVModelScreenState createState() => _CVModelScreenState();
}

class _CVModelScreenState extends State<CVModelScreen> {
  @override
  void initState() {
    super.initState();
    _redirectToLink();
  }

  // Method to redirect the user as soon as the page loads
  Future<void> _redirectToLink() async {
    final url = 'https://your-api-url.com/cvmodel'; // Replace with your desired link

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // You can process the response here if needed
        print('Successfully fetched the data: ${response.body}');
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }

      // Navigate to the next screen after the API call (replace with your actual screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FetchedDataScreen(data: response.body)), // Pass data to the next screen
      );
    } catch (error) {
      // Handle error and show a message if needed
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redirecting...'),
        centerTitle: true,
      ),
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator while redirecting
      ),
    );
  }
}

class FetchedDataScreen extends StatelessWidget {
  final String data;

  FetchedDataScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetched Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data from the API:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(data), // Display the fetched data
          ],
        ),
      ),
    );
  }
}
