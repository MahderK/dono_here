import 'package:flutter/material.dart';

class DonoHereApp extends StatelessWidget {
  const DonoHereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DonoHere',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const Scaffold(body: Center(child: Text('DonoHere'))),
    );
  }
}
