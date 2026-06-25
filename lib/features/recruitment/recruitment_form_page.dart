// 2. 募集する
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Event {
  const Event({required this.title});

  final String title;
}

class RecruitmentFormPage extends StatefulWidget {
  const RecruitmentFormPage({super.key, required this.event});

  final Event event;

  @override
  State<RecruitmentFormPage> createState() => _RecruitmentFormPageState();
}

class _RecruitmentFormPageState extends State<RecruitmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _purposeController = TextEditingController();
  final _meetingTimeController = TextEditingController();
  final _messageController = TextEditingController();
  int _capacity = 1;

  @override
  void dispose() {
    _purposeController.dispose();
    _meetingTimeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _openConfirmation() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('入力内容の確認'),
          content: Text(
            '募集目的: ${_purposeController.text}\n'
            '集合時間: ${_meetingTimeController.text}\n'
            '募集人数: $_capacity人\n'
            'メッセージ: ${_messageController.text}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  void _selectTime() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          use24hFormat: true,
          onDateTimeChanged: (time) {
            _meetingTimeController.text =
                '${time.hour.toString().padLeft(2, '0')}:'
                '${time.minute.toString().padLeft(2, '0')}';
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('同行募集を作る')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              Text(
                widget.event.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),

              const Text(
                '一緒に参加したい人へ希望する条件を伝えましょう。',
                style: TextStyle(color: Color(0xFF66717E)),
              ),

              const SizedBox(height: 24),

              //募集目的の入力
              TextFormField(
                controller: _purposeController,
                decoration: const InputDecoration(
                  labelText: '募集目的',
                  hintText: '例: 初参加なので一緒に見学したい',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '募集目的を入力してください';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              //集合時間の入力
              TextFormField(
                controller: _meetingTimeController,
                readOnly: true,
                onTap: _selectTime,
                decoration: const InputDecoration(
                  labelText: '集合時間',
                  hintText: '例: 13:45',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.schedule_rounded),
                ),
                textInputAction: TextInputAction.next,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '集合時間を入力してください';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              //募集人数の入力
              DropdownButtonFormField<int>(
                initialValue: _capacity,
                decoration: const InputDecoration(
                  labelText: '募集人数',
                  border: OutlineInputBorder(),
                ),
                items: List.generate(4, (index) {
                  final number = index + 1;
                  return DropdownMenuItem(
                    value: number,
                    child: Text('$number人'),
                  );
                }),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _capacity = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              //補足情報の入力
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'メッセージ',
                  hintText: '例: 初めての人も大歓迎です',
                ),
              ),

              const SizedBox(height: 24),

              //確認警告ボタン
              FilledButton.icon(
                onPressed: _openConfirmation,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('入力内容を確認する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
