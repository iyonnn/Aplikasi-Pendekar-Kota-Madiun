// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class webbookingprc extends StatefulWidget {
  const webbookingprc({Key? key}) : super(key: key);

  @override
  _webbookingprcState createState() => _webbookingprcState();
}

class _webbookingprcState extends State<webbookingprc> {
  bool isLoading = true;
  InAppWebViewController? _webViewController;
  final String url = 'https://bookingprc.madiunkota.go.id/';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptEnabled: true,
                        clearCache: true,
                        cacheEnabled: true,
                        transparentBackground: true,
                        supportZoom: false,
                        allowFileAccessFromFileURLs: true,
                        allowUniversalAccessFromFileURLs: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                      // Menggunakan JavaScript untuk menyembunyikan elemen yang tidak diinginkan
                      //           controller.evaluateJavascript(source: '''
                      //             var element = document.getElementsByClassName('navbar')[0];
                      //   if (element != null) {
                      //     element.style.display = 'none';
                      //   }
                      //    var sideMenu = document.getElementsByClassName('toolbar')[0];
                      //   if (sideMenu != null) {
                      //     sideMenu.style.display = 'none';
                      //   }
                      //   var header = document.getElementsByClassName('account-masthead')[0];
                      //   if (header != null) {
                      //     header.style.display = 'none';
                      //   }
                      //   var footer = document.getElementsByClassName('footer pt-5')[0];
                      //   if (footer != null) {
                      //     footer.style.display = 'none';
                      //   }
                      //   var second = document.getElementsByClassName('secondary col-md-3')[0];
                      //   if (second != null) {
                      //     second.style.display = 'none';
                      //   }

                      // ''');
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: const Color.fromARGB(255, 6, 97, 94),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: screenWidth * 0.3,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 97, 94),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.home,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        Text(
                          'Kembali Ke Menu',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () {
                    if (_webViewController != null) {
                      _webViewController?.reload();
                    }
                  },
                  child: Container(
                    width: screenWidth * 0.3,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 97, 94),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.refresh,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        Text(
                          'Reload',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () {
                    if (_webViewController != null) {
                      _webViewController?.goBack();
                    }
                  },
                  child: Container(
                    width: screenWidth * 0.3,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 97, 94),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_back,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        Text(
                          'Page Sebelumnya',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
