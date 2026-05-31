import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/article_site.dart';

class WebViewPage extends StatefulWidget {
  final ArticleSite site;

  const WebViewPage({
    super.key,
    required this.site,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loadingProgress = progress;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.site.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.site.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (loadingProgress < 100)
            LinearProgressIndicator(
              value: loadingProgress / 100,
            ),
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
    );
  }
}