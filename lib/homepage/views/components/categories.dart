import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/peceltumpang.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_launcher_name/flutter_launcher_name.dart';

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
        "text": "MADIUNTODAY",
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
        width: 85,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Sudut melengkung
                ),
                elevation: 6, // Bayangan untuk efek 3D
                shadowColor: Colors.black.withOpacity(0.9), // Warna bayangan
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: hThirdColor,
                    borderRadius: BorderRadius.circular(10),
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
