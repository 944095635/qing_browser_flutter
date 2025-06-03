import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
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
      )
      ..loadRequest(Uri.parse('https://www.baidu.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        title: Center(
          child: Hero(
            tag: "search",
            child: Material(
              type: MaterialType.transparency,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "输入网址...",
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.loadRequest(Uri.parse(value));
                  }
                },
              ),
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
}
