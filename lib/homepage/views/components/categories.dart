// ignore_for_file: duplicate_import, unused_import, deprecated_member_use

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
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/opendata.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/peceltumpang.dart';
import 'package:pendekar/homepage/menu/layananAsn.dart';
import 'package:pendekar/homepage/menu/layanankesehatan.dart';
import 'package:pendekar/homepage/menu/layananpengaduan.dart';
import 'package:pendekar/homepage/menu/layananpublik.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:pendekar/homepage/views/components/dialogWarning.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:url_launcher/url_launcher.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = Duration(milliseconds: 500);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/imgicon/mbangun.png",
        "text": "MBANGUN SWARGA",
        "page": WebMcm(),
      },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": webmanekin(),
      },
      // {
      //   "icon": "assets/images/imgicon/puskesmas.png",
      //   "text": "Layanan Kesehatan",
      //   "page": LayananKesehatan(),
      // },
      // // {
      // //   "icon": "assets/images/imgicon/aspirasirakyat.png",
      // //   "text": "MANEKIN",
      // //   "page": webmanekin(),
      // // },
    ];

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

    void showAllApps(String categoryText) {
      Widget page;
      switch (categoryText) {
        case "MBANGUN SWARGA":
          page = WebMcm();
          break;
        case "MANEKIN":
          page = webmanekin();
          break;
        // case "Layanan Kesehatan":
        //   page = LayananKesehatan();
        //   break;
        // case "Layanan Pengaduan":
        //   page = LayananPengaduan();
        //   break;
        default:
          return; // Handle default case here
      }

      showModalBottomSheet(
        transitionAnimationController: controller,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return page;
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio:
            2, // Sesuaikan untuk mengontrol tinggi vs lebar (semakin besar = item lebih pipih)
        shrinkWrap:
            true, // Penting agar GridView tidak ambil semua tinggi layar
        physics:
            NeverScrollableScrollPhysics(), // Biar scroll ikut parent, bukan GridView
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => categories[index]["page"],
                ),
              );
            },
          ),
        ),
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
    double cardWidth =
        (screenWidth - 80) / 2; // 2 card sejajar, jarak 20px antar sisi
    double fontSize = screenWidth * 0.030;

    return GestureDetector(
      onTap: press,
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.greenAccent
            ], // Gradasi warna biru
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Row(
            children: [
              Image.asset(icon,
                  width: screenWidth * 0.25, height: screenWidth * 0.25),
              SizedBox(width: screenWidth * 0.010),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_call_super, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, unnecessary_null_comparison, prefer_is_empty, sized_box_for_whitespace, unused_local_variable, no_leading_underscores_for_local_identifiers

