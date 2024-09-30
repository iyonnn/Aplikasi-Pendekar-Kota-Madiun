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
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
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
        "icon": "assets/images/imgicon/pecel.png",
        "text": "Pecel Tumpang",
        "page": WebPecel(),
      },
      {
        "icon": "assets/images/imgicon/matawarga.png",
        "text": "Layanan Publik",
        "page": LayananPublik(),
      },
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "Layanan Kesehatan",
        "page": LayananKesehatan(),
      },
      {
        "icon": "assets/images/imgicon/aspirasirakyat.png",
        "text": "Layanan Pengaduan",
        "page": LayananPengaduan(),
      },
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
        case "Pecel Tumpang":
          page = WebPecel();
          break;
        case "Layanan Publik":
          page = LayananPublik();
          break;
        case "Layanan Kesehatan":
          page = LayananKesehatan();
          break;
        case "Layanan Pengaduan":
          page = LayananPengaduan();
          break;
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
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              if (categories[index]["text"] == "Pecel Tumpang") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => categories[index]["page"],
                  ),
                );
                return; // Keluar dari fungsi press setelah menavigasi
              }

              if (categories[index].containsKey("appId") &&
                  categories[index].containsKey("uriScheme")) {
                openApp(
                  categories[index]["appId"],
                  categories[index]["uriScheme"],
                );
              } else {
                if (categories[index]["page"] is DialogWarning) {
                  DialogWarning.show(context);
                } else {
                  showAllApps(categories[index]["text"]);
                }
              }
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
    double fontSize = screenWidth * 0.030;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 80,
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
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hThirdColor.withOpacity(0.5).withOpacity(0.5),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(icon, width: 35, height: 35),
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

