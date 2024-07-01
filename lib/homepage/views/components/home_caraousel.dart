// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, deprecated_member_use, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_field

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeCaraousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeCraouselState();
}

class _HomeCraouselState extends State<HomeCaraousel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, String>> imgNews = [];

  @override
  void initState() {
    super.initState();
    fetchLatestImages();
  }

  Future<void> fetchLatestImages() async {
    List<String> urls = [
      'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json',
      'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json',
      'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json',
    ];

    for (var url in urls) {
      try {
        var imageAndText = await fetchLatestImageAndTextFromRss(url);
        if (imageAndText != null) {
          setState(() {
            imgNews.add(imageAndText);
          });
        }
      } catch (e) {
        print('Error fetching image from $url: $e');
      }
    }
  }

  Future<Map<String, String>?> fetchLatestImageAndTextFromRss(
      String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> items = data['items'];

      if (items.isNotEmpty) {
        var latestItem = items.first; // Ambil postingan terbaru
        if (latestItem['attachments'] != null &&
            latestItem['attachments'].isNotEmpty) {
          return {
            'imageUrl': latestItem['attachments'][0]['url'],
            'contentText': latestItem['content_text'] ?? '',
            'title': data['title'] ?? 'Instagram Post',
            'instagramUrl': latestItem['url'], // URL postingan Instagram
          };
        }
      }
      return null; // Kembalikan null jika tidak ada gambar
    } else {
      throw Exception('Failed to load RSS feed');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 2,
        aspectRatio: 1.8,
      ),
      items: imgNews.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _launchInstagram(item['instagramUrl']!);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                width: size.width * 1,
                height: size.height * 1,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    15), // Sesuaikan radius dengan keinginan Anda
                                child: Image.network(
                                  item['imageUrl']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                5, 40, 28, 3), // Ubah padding di sini
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 1,
                                  height: size.height * 0.15,
                                  child: Text(
                                    item['contentText']!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    maxLines: 6,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 1,
                      left: size.width * 0.4,
                      child: Container(
                        width: size.width * 0.57,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 1),
                            colors: <Color>[
                              Color(0xff1f005c),
                              Color(0xff5b0060),
                              Color(0xff870160),
                              Color(0xffac255e),
                              Color(0xffca485c),
                              Color(0xffe16b5c),
                              Color(0xfff39060),
                              Color(0xffffb56b),
                            ], // Gradient from https://learnui.design/tools/gradient-generator.html
                            tileMode: TileMode.mirror,
                          ),
                          // Warna hitam dengan opacity
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons
                                  .instagram, // Icon untuk Instagram
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: size.width * 0.47,
                              height: size.height * 0.1,
                              child: Text(
                                item['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 8.0,
                      spreadRadius: 3.0,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // Fungsi untuk membuka aplikasi Instagram atau browser dengan URL postingan
  void _launchInstagram(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
