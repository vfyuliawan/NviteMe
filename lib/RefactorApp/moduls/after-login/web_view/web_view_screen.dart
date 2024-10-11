// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String slug;
  const WebViewScreen({Key? key, required this.slug}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    // Initialize WebViewController
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally handle progress changes.
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            print(
                'Error loading page: ${error.errorCode}, ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation for now (including YouTube)
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://${Constans.baseUrlDev}${widget.slug}'));

    // Enable hybrid composition for Android
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndrwoidWebView();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constans.secondaryColor,
        title: const Text("Preview"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
