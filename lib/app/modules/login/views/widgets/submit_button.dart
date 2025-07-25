import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

// Widget SubmitButton({required VoidCallback onTap, required String text}) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//       width: Get.width,
//       padding: EdgeInsets.symmetric(vertical: 15),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: Colors.grey.shade200,
//                 offset: Offset(2, 4),
//                 blurRadius: 5,
//                 spreadRadius: 2)
//           ],
//           gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [Styles.secondaryBlueColor, Styles.primaryBlueColor])),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 20, color: Colors.white),
//       ),
//     ),
//   );
// }

class SubmitButton extends StatelessWidget {
  SubmitButton({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Styles.secondaryBlueColor, Styles.primaryBlueColor])),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
