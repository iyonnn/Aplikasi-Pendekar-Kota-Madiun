import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/digiform.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrianPuskes.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrianRS.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:pendekar/homepage/views/components/Screen_aplikasi%20_lainya.dart';

class CategoriesSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/imgicon/digiform.png",
        "text": "DIGIFORM DUKCAPIL",
        "page": const webdigiform(),
      },
      {
        "icon": "assets/images/imgicon/rumahsakit.png",
        "text": "ANTRIAN RUMAH SAKIT SOGATEN",
        "page": const webantrianrs()
      },
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "ANTRIAN PUSKESMAS KOTA MADIUN",
        "page": const webantrianpuskes()
      },
      {
        "icon": "assets/images/imgicon/menu.png",
        "text": "Layanan Lainnya >",
        "page": const Semuaaplikasi()
      },
    ];
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
              categories.length,
              (index) => CategoryCardSecond(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => categories[index]["page"]),
                      );
                    },
                  ))
        ],
      ),
    );
  }
}

class CategoryCardSecond extends StatelessWidget {
  const CategoryCardSecond({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
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
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pendekar/constants/constant.dart';
// import 'package:pendekar/homepage/size_config.dart';

// class CategoriesSecond extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/images/lambangmadiun.png", "text": "EDU"},
//       {"icon": "assets/images/lambangmadiun.png", "text": "Pecel Tumpang"},
//       {"icon": "assets/images/lambangmadiun.png", "text": "Antrian RS"},
//       {"icon": "assets/images/lambangmadiun.png", "text": "Antrian Puskesmas"},
//       {"icon": "assets/images/imgicon/menu.png", "text": "Lainnya"},
//     ];
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ...List.generate(
//               categories.length,
//               (index) => CategoryCardSecond(
//                     icon: categories[index]["icon"],
//                     text: categories[index]["text"],
//                     press: () {},
//                   ))
//         ],
//       ),
//     );
//   }
// }

// class CategoryCardSecond extends StatelessWidget {
//   const CategoryCardSecond({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.press,
//   }) : super(key: key);

//   final String icon, text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: getProportionateScreenWidth(55),
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 1,
//               child: Container(
//                 padding: EdgeInsets.all(getProportionateScreenWidth(15)),
//                 height: getProportionateScreenWidth(55),
//                 width: getProportionateScreenWidth(55),
//                 decoration: BoxDecoration(
//                   color: hThirdColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Image.asset(icon, width: 10, height: 10),
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               text,
//               textAlign: TextAlign.center,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
