// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String slug;
  const WebView({Key? key, required this.slug}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // https://your-wedding-day-git-main-vfyuliawans-projects.vercel.app/?a=Debby-Surya&to=GALANG
      ..loadRequest(Uri.parse('${Constans.baseUrlDeploy}${widget.slug}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constans.secondaryColor,
        title: const Text("Perview"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
