import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller;
  late TextEditingController editingController;
  late FocusNode focusNode;
  Uri? initUrl;

  @override
  void initState() {
    super.initState();
    initUrl = Get.arguments;

    // 初始化焦点节点
    focusNode = FocusNode();
    // 初始化编辑控制器
    editingController = TextEditingController();
    // 初始化 WebView 控制器
    controller = WebViewController()
      ..setBackgroundColor(Colors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    if (initUrl != null) {
      controller.loadRequest(initUrl!);
      editingController.text = initUrl!.toString();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(Durations.extralong4);
        // UI 渲染完成后的回调
        focusNode.requestFocus();
        await Future.delayed(Durations.extralong4);
        if (!focusNode.hasFocus) {
          focusNode.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // 释放焦点节点
    focusNode.dispose();
    // 释放编辑控制器
    editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        title: Hero(
          tag: "search",
          child: Material(
            type: MaterialType.transparency,
            child: TextField(
              focusNode: focusNode,
              controller: editingController,
              decoration: InputDecoration(
                hintText: "输入网址",
                suffixIcon: IconButton(
                  onPressed: () {
                    loadUrl(editingController.text);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
              onSubmitted: (value) {
                loadUrl(value);
              },
            ),
          ),
        ),
      ),
      //让键盘盖住内容-防止loading跳动
      resizeToAvoidBottomInset: false,
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  void loadUrl(String url) {
    if (url.isNotEmpty) {
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
      controller.loadRequest(Uri.parse(url));
    }
  }
}
