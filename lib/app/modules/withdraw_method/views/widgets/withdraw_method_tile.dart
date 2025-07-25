import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

class WithdrawMethodTile extends StatelessWidget {
  const WithdrawMethodTile(
      {Key? key,
      required this.name,
      required this.email,
      required this.method,
      required this.onTap})
      : super(key: key);

  final String name;
  final String email;
  final String method;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 68,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Color(0x04000000),
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: Offset(0.0, 8.0))
            ],
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (method == "Paypal") ...[
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.whiteGreyColor,
                      image: DecorationImage(
                        image: AssetImage("assets/images/download1.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ] else ...[
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.whiteGreyColor,
                      image: DecorationImage(
                        image: AssetImage("assets/images/download2.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      method,
                      style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  email,
                  style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Styles.greyTextColor),
                ),
                SizedBox(
                  width: 16,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
