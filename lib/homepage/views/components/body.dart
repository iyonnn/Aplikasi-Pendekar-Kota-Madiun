// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:pendekar/homepage/views/components/categories.dart';
import 'package:pendekar/homepage/views/components/categories_second.dart';
import 'package:pendekar/homepage/views/components/home_banner.dart';
import 'package:pendekar/homepage/views/components/home_caraousel.dart';
import 'package:pendekar/homepage/views/components/home_description.dart';
import 'package:pendekar/homepage/views/components/home_header.dart';
import 'package:pendekar/homepage/views/components/home_wa.dart';
import 'package:pendekar/homepage/views/components/ppidbanner.dart';
import 'package:pendekar/homepage/views/components/radio93fm.dart';
import 'package:pendekar/homepage/views/components/search_field.dart';

import 'icon_btn_with_counter.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HomeBanner(),
            SizedBox(
              height: size.height * 0.02,
            ),
            whatsapp(),
            SizedBox(
              height: size.height * 0.02,
            ),
            Categories(),
            SizedBox(
              height: size.height * 0.01,
            ),
            CategoriesSecond(),
            SizedBox(
              height: size.height * 0.01,
            ),
            ppidBanner(),
            SizedBox(
              height: size.height * 0.01,
            ),
            HomePlayer(),
            SizedBox(
              height: size.height * 0.01,
            ),
            HomeDescription(),
            HomeCaraousel(),
          ],
        ),
      ),
    );
  }
}
