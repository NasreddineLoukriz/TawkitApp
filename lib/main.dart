import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tawkit/features/webview/presentation/screens/webview.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   final localhostServer = InAppLocalhostServer(documentRoot: 'assets/');

  await localhostServer.start();
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:WebviewC(),
    );
  }
}
