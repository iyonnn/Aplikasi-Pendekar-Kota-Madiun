// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenData extends StatelessWidget {
  final List<Map<String, String>> cardData = [
    {
      'name': 'Dashboard',
      'url': 'https://opendata.madiunkota.go.id/',
      'image': 'assets/imgOpendata/dashboard.png'
    },
    {
      'name': 'Dataset',
      'url': 'https://opendata.madiunkota.go.id/dataset/list/1',
      'image': 'assets/imgOpendata/dataset.png'
    },
    {
      'name': 'Organisasi',
      'url': 'https://opendata.madiunkota.go.id/organization',
      'image': 'assets/imgOpendata/organization.png'
    },
    {
      'name': 'Tag',
      'url': 'https://opendata.madiunkota.go.id/tag',
      'image': 'assets/imgOpendata/group.png'
    },
    {
      'name': 'Standar Data',
      'url': 'https://opendata.madiunkota.go.id/standar/data',
      'image': 'assets/imgOpendata/about.png'
    },
    {
      'name': 'Dokumen',
      'url': 'https://opendata.madiunkota.go.id/dokumen',
      'image': 'assets/imgOpendata/about.png'
    },
    {
      'name': 'Infografis',
      'url': 'https://opendata.madiunkota.go.id/infografis',
      'image': 'assets/imgOpendata/about.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 6, 97, 94),
                Color.fromARGB(255, 6, 97, 94),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Open Data Kota Madiun",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.builder(
            itemCount: cardData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleCardTap(context, cardData[index]['url']!),
                child: Card(
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.020,
                    horizontal: screenWidth * 0.030,
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    height: screenHeight *
                        0.25, // Adjust this value to your desired card height
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: AssetImage(cardData[index]['image']!),
                              fit: BoxFit
                                  .contain, // Make sure to use BoxFit.cover to fill the entire card
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: screenWidth * 0.80,
                              padding: EdgeInsets.fromLTRB(
                                screenWidth * 0.020,
                                screenWidth * 0.020,
                                screenWidth * 0.020,
                                screenWidth * 0.020,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 6, 97, 94)
                                    .withOpacity(1),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                cardData[index]['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    // Meminta izin di sini
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();

    // Cek apakah izin diberikan atau tidak
    if (statuses[Permission.camera]?.isGranted == false) {
      print('Permission to access camera is denied');
    }
    if (statuses[Permission.storage]?.isGranted == false) {
      print('Permission to access storage is denied');
    }
    if (statuses[Permission.photos]?.isGranted == false) {
      print('Permission to access photos is denied');
    }
    if (statuses[Permission.mediaLibrary]?.isGranted == false) {
      print('Permission to access media library is denied');
    }
    if (statuses[Permission.accessMediaLocation]?.isGranted == false) {
      print('Permission to access media location is denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.035; // 5% dari lebar layar
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
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        clearCache: false,
                        cacheEnabled: true,
                        transparentBackground: true,
                        supportZoom: true,
                        useOnDownloadStart: true,
                        mediaPlaybackRequiresUserGesture: false,
                        allowFileAccessFromFileURLs: true,
                        allowUniversalAccessFromFileURLs: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                        javaScriptEnabled: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                        allowContentAccess: true,
                        allowFileAccess: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    androidOnPermissionRequest:
                        (InAppWebViewController controller, String origin,
                            List<String> resources) async {
                      var response = await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Permintaan Izin"),
                          content: Text(
                              "Ijinkan aplikasi mengakses foto dan media?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(PermissionRequestResponseAction.GRANT);
                              },
                              child: Text("Izinkan Akses"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(PermissionRequestResponseAction.DENY);
                              },
                              child: Text("Tolak Akses"),
                            ),
                          ],
                        ),
                      );

                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    // Event lainnya di sini

                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                      // Menggunakan JavaScript untuk menyembunyikan elemen yang tidak diinginkan
                      controller.evaluateJavascript(source: '''
                        var element = document.getElementsByClassName('navbar')[0];
              if (element != null) {
                element.style.display = 'none';
              }
               var sideMenu = document.getElementsByClassName('toolbar')[0];
              if (sideMenu != null) {
                sideMenu.style.display = 'none';
              }
              var header = document.getElementsByClassName('account-masthead')[0];
              if (header != null) {
                header.style.display = 'none';
              }
              var footer = document.getElementsByClassName('footer pt-5')[0];
              if (footer != null) {
                footer.style.display = 'none';
              }
              var second = document.getElementsByClassName('secondary col-md-3')[0];
              if (second != null) {
                second.style.display = 'none';
              }
             
            ''');
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
                            fontSize: fontSize,
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
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () async {
                    if (_webViewController != null) {
                      bool canGoBack = await _webViewController!.canGoBack();
                      if (canGoBack) {
                        _webViewController?.goBack();
                      } else {
                        Navigator.of(context).pop();
                      }
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
