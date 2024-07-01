import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SSO Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }

class LoginPage extends StatelessWidget {
  final String ssoAuthorizeUrl = 'https://sso.example.com/oauth/authorize';
  final String ssoTokenUrl = 'https://sso.example.com/oauth/token';
  final String ssoRedirectUri = 'your_app_redirect_uri';
  final String ssoClientId = 'your_client_id';
  final String ssoClientSecret = 'your_client_secret';
  final String ssoScope = 'openid profile';

  Future<void> _login(BuildContext context) async {
    final authorizationUrl =
        '$ssoAuthorizeUrl?response_type=code&client_id=$ssoClientId&redirect_uri=$ssoRedirectUri&scope=$ssoScope';
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SsoLoginPage(authorizationUrl),
      ),
    );
    if (result != null && result is String) {
      final tokenUrl = Uri.parse(ssoTokenUrl);
      final response = await http.post(
        tokenUrl,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'authorization_code',
          'client_id': ssoClientId,
          'client_secret': ssoClientSecret,
          'redirect_uri': ssoRedirectUri,
          'code': result,
        },
      );

      if (response.statusCode == 200) {
        final tokenResponse = jsonDecode(response.body);
        final accessToken = tokenResponse['access_token'];

        // Simpan token akses ke shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', accessToken);

        // Lakukan tindakan setelah berhasil login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to retrieve access token'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: Text('Login with SSO'),
        ),
      ),
    );
  }
}

class SsoLoginPage extends StatefulWidget {
  final String authorizationUrl;

  SsoLoginPage(this.authorizationUrl);

  @override
  _SsoLoginPageState createState() => _SsoLoginPageState();
}

class _SsoLoginPageState extends State<SsoLoginPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSO Login'),
      ),
      body: Stack(
        children: [
          WebviewScaffold(
            url: "https://absen.madiunkota.go.id/",
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

class HomePage extends StatelessWidget {
  _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  _getUserInfo(String accessToken) async {
    final userInfoUrl = 'https://sso.example.com/userinfo';
    final headers = {'Authorization': 'Bearer $accessToken'};
    final response = await http.get(Uri.parse(userInfoUrl), headers: headers);
    if (response.statusCode == 200) {
      final userInfo = jsonDecode(response.body);
      return userInfo;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<String>(
        future: _getAccessToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final accessToken = snapshot.data;
            return FutureBuilder<Map<String, dynamic>>(
              future: _getUserInfo(accessToken!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userInfo = snapshot.data;
                  final username = userInfo!['username'];
                  return Center(
                    child: Text('Welcome, $username'),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch user information'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to retrieve access token'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
