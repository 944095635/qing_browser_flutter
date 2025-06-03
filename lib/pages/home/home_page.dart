import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qing/pages/scan/scan_page.dart';
import 'package:qing/pages/web/web_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        spacing: 60,
        children: [
          Text(
            "Qing",
            style: TextStyle(
              fontSize: 64,
              fontFamily: "Prompt",
              fontWeight: FontWeight.w200,
            ),
          ),
          _buildSearchBox(),
        ],
      ),
    );
  }

  /// 搜索区域
  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Hero(
        tag: 'search',
        child: Material(
          type: MaterialType.transparency,
          child: TextField(
            canRequestFocus: false,
            decoration: InputDecoration(
              hintText: "输入网址...",
              suffixIcon: IconButton(
                onPressed: () {
                  Get.to(
                    () => const ScanPage(),
                    transition: Transition.fadeIn,
                    duration: Durations.extralong2,
                  );
                },
                icon: SvgPicture.asset(
                  "svgs/scan.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.black54,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            onTap: () {
              Get.to(
                () => const WebPage(),
                transition: Transition.fade,
                duration: Durations.extralong2,
              );
            },
          ),
        ),
      ),
    );
  }
}
