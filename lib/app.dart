import 'package:flutter/material.dart';

class EventPairApp extends StatelessWidget {
  const EventPairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Pair',
      home: const Scaffold(body: Center(child: Text('サンプル'))),
    );
  }
}
