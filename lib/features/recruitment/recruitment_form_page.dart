// 2. 募集する
import 'package:flutter/material.dart';

class RecruitmentFormPage extends StatefulWidget {
  const RecruitmentFormPage({super.key, required this.event});

  final Event event;

  @override
  State<RecruitmentFormPage> createState() => _RecruitmentFormPageState();
}

class _RecruitmentFormPageState extends State<RecruitmentFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('同行募集を作る')));
  }
}
