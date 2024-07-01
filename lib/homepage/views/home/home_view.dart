import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/body.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}


// class HomePage extends StatefulWidget {
//   const HomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: getBody(),
//     );
//   }

//   Widget getBody() {
//     var size = MediaQuery.of(context).size;
//     return ListView(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Padding(
//                     padding:
//                         EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
//                     child: Row(
//                       children: [Text("data")],
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
