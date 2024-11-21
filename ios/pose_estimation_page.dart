import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class PoseEstimationPage extends StatefulWidget {
  @override
  _PoseEstimationPageState createState() => _PoseEstimationPageState();
}

class _PoseEstimationPageState extends State<PoseEstimationPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  // Request camera permission
  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      // Show a dialog to prompt the user to grant camera permission
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Camera Permission Required'),
            content: Text('Please allow camera access to use this feature.'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  // Request camera permission
                  status = await Permission.camera.request();
                  if (status.isGranted) {
                    await _initializeCamera();  // Call initialization after permission is granted
                  } else {
                    // Handle permission denied case
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Camera permission denied.')),
                    );
                  }
                },
                child: Text('Allow'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      await _initializeCamera();
    }
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      print('Available cameras: $_cameras');  // Log available cameras
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0], // Use the first available camera
          ResolutionPreset.high,
        );

        await _cameraController!.initialize();
        print('Camera initialized successfully');  // Log success
        setState(() {
          _isInitialized = true;  // Set initialized to true after successful initialization
        });
      } else {
        // Handle case where no cameras are available
        print('No cameras available');  // Log no cameras
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No cameras available.')),
        );
      }
    } catch (e) {
      // Handle initialization errors
      print('Error initializing camera: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing camera: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pose Estimation'),
      ),
      body: Center(
        child: Container(
          width: 300,  // Width of the camera box
          height: 400,  // Height of the camera box
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),  // Border for the box
            borderRadius: BorderRadius.circular(12),  // Rounded corners
            color: Colors.black,  // Background color of the box
          ),
          child: _isInitialized
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),  // Match the box's border radius
                  child: AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
