// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class websamrtcity extends StatefulWidget {
  const websamrtcity({Key? key}) : super(key: key);

  @override
  _websamrtcityState createState() => _websamrtcityState();
}

class _websamrtcityState extends State<websamrtcity> {
  bool isLoading = true;
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    Timer(Duration(seconds: 10), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.startLoad) {
        startLoading();
      } else if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[100],
        elevation: 0, // Menghilangkan bayangan di bawah AppBar
        title: Text(
          'Aplikasi Smartcity Kota Madiun',
          style: TextStyle(
            color: Colors.black, // Warna teks judul
            fontSize: 20, // Ukuran teks judul
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined, // Icon untuk menu navigasi
            color: Colors.black, // Warna ikon
          ),
          onPressed: () {
            Navigator.pop(context);
            // Aksi ketika ikon menu diklik
          },
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          WebviewScaffold(
            url: "https://smartcity.madiunkota.go.id/",
            withJavascript: true,
            withZoom: true,
            withLocalStorage: true,
            hidden: false,
            ignoreSSLErrors: true,
            appCacheEnabled: true,
          ),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color.fromARGB(255, 212, 0, 255),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 221, 0, 0),
                    ),
                    backgroundColor: Color.fromARGB(255, 212, 0, 255),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                    child: Text("Mohon Menunggu..."),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
