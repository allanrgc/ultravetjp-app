import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:ultravetjp_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UltraVet JP',
      theme: ThemeData(
        primarySwatch: Colors.green, // Você pode customizar o tema aqui
        fontFamily: 'Lato', // Exemplo de fonte customizada
      ),
      debugShowCheckedModeBanner: false, // Remove a faixa "Debug"
      home: const HomeScreen(), // <-- DEFINA A HomeScreen COMO TELA INICIAL
    );
  }
}