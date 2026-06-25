import 'package:flutter/material.dart';

import 'recruitment_form_page.dart';

class RecruitmentConfirmationPage extends StatelessWidget {
  const RecruitmentConfirmationPage({
    super.key,
    required this.event,
    required this.draft,
  });

  final Event event;
  final Object draft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('募集内容の確認')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('対象イベント: ${event.title}'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
