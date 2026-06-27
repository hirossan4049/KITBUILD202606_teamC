import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'features/discovery/discovery_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Firebaseへメールアドレスとパスワードを送り、新規登録する。
  Future<void> _signUp() async {
    // メールアドレスの前後にある不要な空白を削除する。
    final email = _emailController.text.trim();

    // 入力されたパスワードを取得する。
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('メールアドレスとパスワードを入力してください')));
      return;
    }

    try {
      // Firebaseの新規登録が完了するまで待つ。
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 登録中に画面が閉じられていた場合は、画面を操作しない。
      if (!mounted) {
        return;
      }

      // 登録に成功したら、イベントを見つける画面へ進む。
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DiscoveryPage()),
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('FirebaseAuthException: ${error.code} ${error.message}');

      // Firebaseのエラーを表示するための初期メッセージ。
      String message = '新規登録に失敗しました';

      // Firebaseから返されたエラーの種類を日本語へ置き換える。
      if (error.code == 'weak-password') {
        message = 'パスワードは6文字以上にしてください';
      } else if (error.code == 'email-already-in-use') {
        message = 'このメールアドレスは登録済みです';
      } else if (error.code == 'invalid-email') {
        message = 'メールアドレスの形式が正しくありません';
      } else if (error.code == 'operation-not-allowed') {
        message = 'Firebaseでメール/パスワード登録が有効になっていません';
      } else if (error.code == 'configuration-not-found') {
        message = 'Firebase Authenticationの設定がまだ作成されていません';
      } else if (error.code == 'network-request-failed') {
        message = 'ネットワーク接続を確認してください';
      } else if (error.code == 'too-many-requests') {
        message = '短時間に何度も試したため一時的に制限されています';
      }

      // 登録中に画面が閉じられていた場合は、画面を操作しない。
      if (!mounted) {
        return;
      }

      // 新規登録に失敗した理由を画面下部へ表示する。
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void dispose() {
    // メールアドレス用Controllerが使っていたメモリを解放する。
    _emailController.dispose();

    // パスワード用Controllerが使っていたメモリを解放する。
    _passwordController.dispose();

    // StatefulWidget本来の終了処理も実行する。
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新規登録')),
      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
            ),
            TextField(
              controller: _passwordController,

              obscureText: true,

              decoration: const InputDecoration(labelText: 'パスワード'),
            ),

            FilledButton(onPressed: _signUp, child: const Text('登録する')),
          ],
        ),
      ),
    );
  }
}
