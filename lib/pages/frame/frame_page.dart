import 'package:flutter/material.dart';
import 'package:qing/pages/home/home_page.dart';

class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: HomePage(),
    );
  }
}
