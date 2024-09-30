// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementCard extends StatelessWidget {
  final String announcementText;
  final Function onPressed;

  const AnnouncementCard({
    Key? key,
    required this.announcementText,
    required this.onPressed,
  }) : super(key: key);

  void openWhatsApp() async {
    final phoneNumber =
        '08113577800'; // Ganti dengan nomor telepon WhatsApp yang diinginkan
    final whatsappUrl = 'https://wa.me/$phoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSizeL = screenWidth * 0.05;
    double fontSize = screenWidth * 0.03;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () {
          openWhatsApp();
        },
        child: Card(
          elevation: 2,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/paternwa.png'), // Ganti dengan path gambar pattern Anda
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/imgicon/awaksigap.png', // Ganti dengan path logo WhatsApp Anda
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        announcementText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeL,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '(Pengaduan Gawat Darurat Kota Madiun 112)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
