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
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/opendata.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/peceltumpang.dart';
import 'package:pendekar/homepage/menu/berita.dart';
import 'package:pendekar/homepage/menu/lainnya.dart';
import 'package:pendekar/homepage/menu/layananAsn.dart';
import 'package:pendekar/homepage/menu/layananinformasi.dart';
import 'package:pendekar/homepage/menu/layanankesehatan.dart';
import 'package:pendekar/homepage/menu/layananpengaduan.dart';
import 'package:pendekar/homepage/menu/layananpublik.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:pendekar/homepage/views/components/Screen_aplikasi%20_lainya.dart';
import 'package:pendekar/homepage/views/components/dialogWarning.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoriesSecond extends StatefulWidget {
  @override
  _CategoriesSecondState createState() => _CategoriesSecondState();
}

class _CategoriesSecondState extends State<CategoriesSecond>
    with TickerProviderStateMixin {
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
    List<Map<String, dynamic>> CategoriesSecond = [
      {
        "icon": "assets/images/imgicon/mbangun.png",
        "text": "Mbangun Swarga",
        "page": WebMcm(),
      },
      {
        "icon": "assets/images/imgicon/siopa.png",
        "text": "PAJAK",
        "page": DialogWarning(),
      },
      {
        "icon": "assets/images/imgicon/peceltumpang.png",
        "text": "INFORMASI",
        "page": LayananInformasi(),
      },
      {
        "icon": "assets/images/imgicon/menu.png",
        "text": "Semua layanan",
        "page": Semuaaplikasi(),
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
        case "INFORMASI":
          page = LayananInformasi();
          break;
        case "Mbangun Swarga":
          page = WebMcm();
          break;
        case "PAJAK":
          page = LayananKesehatan();
          break;
        case "Semua layanan":
          page = Semuaaplikasi();
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
          CategoriesSecond.length,
          (index) => CategoryCard(
            icon: CategoriesSecond[index]["icon"],
            text: CategoriesSecond[index]["text"],
            press: () {
              if (CategoriesSecond[index]["text"] == "Mbangun Swarga") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesSecond[index]["page"],
                  ),
                );
                return; // Keluar dari fungsi press setelah menavigasi
              }

              if (CategoriesSecond[index].containsKey("appId") &&
                  CategoriesSecond[index].containsKey("uriScheme")) {
                openApp(
                  CategoriesSecond[index]["appId"],
                  CategoriesSecond[index]["uriScheme"],
                );
              } else {
                if (CategoriesSecond[index]["page"] is DialogWarning) {
                  DialogWarning.show(context);
                } else {
                  showAllApps(CategoriesSecond[index]["text"]);
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

