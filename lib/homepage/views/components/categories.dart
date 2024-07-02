// ignore_for_file: duplicate_import, unused_import

// import 'package:flutter_launcher_name/flutter_launcher_name.dart';
import 'dart:async';
import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/peceltumpang.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:url_launcher/url_launcher.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/imgicon/peceltumpang.png",
        "text": "PECEL TUMPANG",
        "page": webpecel(),
      },
      // {
      //   "icon": "assets/images/imgicon/aspirasirakyat.png",
      //   "text": "ASPIRASI RAKYAT",
      //   "page": webaspirasirakyat(),
      // },
      {
        "icon": "assets/images/imgicon/madiuntoday.png",
        "text": "MADIUN TODAY",
        "page": webmadiuntoday(),
      },
      {
        "icon": "assets/images/imgicon/ekinerja.png",
        "text": "E-kinerja Kota Madiun ",
        "appId": "gov.madiun.ekin_madiun_andro",
        "uriScheme": "com.kominfo.pasar_emadiun://",
      },
      {
        "icon": "assets/images/imgicon/awaksigap2.png",
        "text": "AWAK SIGAP KOTA MADIUN",
        "page": webawaksigap(),
      },
    ];

    // Future<void> launchPlayStore(String appId) async {
    //   String playStoreUrl =
    //       'https://play.google.com/store/apps/details?id=$appId';
    //   await launch(playStoreUrl);
    // }

    // void openApp(String appId) async {
    //   if (appId.isNotEmpty) {
    //     bool isAppInstalled = await canLaunch(appId);
    //     if (isAppInstalled) {
    //       await LaunchMode.externalApplication;
    //       // launch(appId);
    //     } else {
    //       await launchPlayStore(appId);
    //     }
    //   } else {
    //     // Tindakan lain ketika tombol ditekan, misalnya membuka halaman web
    //   }
    // }

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
      } else {
        await launchPlayStore(appId);
      }
    }

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press: () {
                if (categories[index].containsKey("appId") &&
                    categories[index].containsKey("uriScheme")) {
                  openApp(
                    categories[index]["appId"],
                    categories[index]["uriScheme"],
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => categories[index]["page"]),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.030;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                shape: CircleBorder(
                    // borderRadius: BorderRadius.circular(15), // Sudut melengkung
                    ),
                elevation: 6, // Bayangan untuk efek 3D
                shadowColor: Colors.black.withOpacity(0.9), // Warna bayangan
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hThirdColor.withOpacity(0.5).withOpacity(0.5),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(icon, width: 10, height: 10),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_call_super, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, unnecessary_null_comparison, prefer_is_empty, sized_box_for_whitespace, unused_local_variable, no_leading_underscores_for_local_identifiers

