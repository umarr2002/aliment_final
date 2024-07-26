import 'package:aliment/pages/login_page.dart';
import 'package:flutter/material.dart';

class LoginCreatePage extends StatefulWidget {
  const LoginCreatePage({super.key});

  @override
  State<LoginCreatePage> createState() => _LoginCreatePageState();
}

class _LoginCreatePageState extends State<LoginCreatePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: PaddingWidget(),
      ),
    );
  }
}
