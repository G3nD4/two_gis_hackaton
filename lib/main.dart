import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_gis_hackaton/core/di/service_locator.dart' as di;
import 'package:two_gis_hackaton/core/launch_mode.dart';
import 'package:two_gis_hackaton/core/i_startup_service.dart';
import 'package:two_gis_hackaton/features/questionnary/ui/pages/questionnary_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupServiceLocator(mode: LaunchMode.release);

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final startupService = di.sl<IStartupService>();

    return MaterialApp(
      title: 'Two GIS Hackaton',
      theme: ThemeData(textTheme: GoogleFonts.onestTextTheme()),
      darkTheme: ThemeData(brightness: Brightness.dark, textTheme: GoogleFonts.onestTextTheme()),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(startupService: startupService),
    );
  }
}

/// Splash screen which performs a required startup fetch before showing
/// the main UI. If fetching fails, user can retry.
class SplashScreen extends StatefulWidget {
  final IStartupService startupService;

  const SplashScreen({super.key, required this.startupService});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      final data = await widget.startupService.fetchSurveyData();
      if (!mounted) return;

      // Navigate to QuestionnaryPage and inject the usecase
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => QuestionnaryPage(interests: data)),
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
