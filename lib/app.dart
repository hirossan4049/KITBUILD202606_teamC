import 'package:flutter/material.dart';

import 'features/recruitment/recruitment_form_page.dart';

class EventPairApp extends StatelessWidget {
  const EventPairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Pair',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const RecruitmentFormPage(),
    );
  }
}
