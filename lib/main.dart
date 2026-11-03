import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/start_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const CognixApp());
}

class CognixApp extends StatelessWidget {
  final Widget? home;

  const CognixApp({
    super.key,
    this.home,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: home ?? const StartScreen(),
    );
  }
}

// Aliases for compatibility
typedef LuminaQuizApp = CognixApp;
typedef TsgQuizApp = CognixApp;
