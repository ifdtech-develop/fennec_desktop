import 'package:flutter/material.dart';
import 'dart:async';

import 'package:webview_cef/webview_cef.dart';

// void main() {
//   runApp(const DashboardGoogle());
// }

class DashboardGoogle extends StatefulWidget {
  const DashboardGoogle({Key? key}) : super(key: key);

  @override
  State<DashboardGoogle> createState() => _DashboardGoogleState();
}

class _DashboardGoogleState extends State<DashboardGoogle> {
  final _controller = WebviewController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // @protected
  // @mustCallSuper

  @override
  void dispose() {
  //   _controller.dispose();
  //   _textController.dispose();
  //   // _controller.removeListener(() {});
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String url = "https://ifdtech-develop.github.io/utils/index.html";
    _textController.text = url;


     _controller.addListener(() { 
      print("_controller.value: ${_controller.value}");
    });

    await _controller.initialize();
    await _controller.initialize();
    // await _controller.reload();

    await _controller.loadUrl(url);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //create a webview with a white background without a appBar
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ClipRRect(
          //borda do container cortada e o texto some ao passar por ela
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          child: Container(
            color: const Color(0xFFE4E4E4),
            child: Center(
              // while webview is loading, show a loading indicator
              child: Webview(_controller)
            ),
          ),
        ),
      ),
    );
  }
}
