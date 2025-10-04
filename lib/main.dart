import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/core/i_startup_service.dart';
import 'package:two_gis_hackaton/core/startup/mock_startup_service.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two GIS Hackaton',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

/// Splash screen which performs a required startup fetch before showing
/// the main UI. If fetching fails, user can retry.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final IStartupService _startupService = MockStartupService();
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _doStartup();
  }

  Future<void> _doStartup() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await _startupService.fetchSurveyData();
      // You can pass `data` to HomeScreen via constructor or a state management
      // solution. For now we ignore it and show the main UI.
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen(surveyData: data)),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Загрузка...'),
                ],
              )
            : _error != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ошибка инициализации:\n\n$_error',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _doStartup,
                    child: const Text('Повторить'),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

/// Minimal HomeScreen — previously the app's main screen. Kept small so it is
/// easy to replace with the full map screen used earlier.
class HomeScreen extends StatelessWidget {
  final List<String> surveyData;

  const HomeScreen({super.key, required this.surveyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Two GIS Hackaton')),
      body: Center(
        child: Text('App initialized. Received: ${surveyData.length} titles'),
      ),
    );
  }
}
