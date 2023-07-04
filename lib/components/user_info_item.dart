import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoItem extends StatelessWidget {
  UserInfoItem({Key? key, required this.title, required this.body, this.withLine= false}) : super(key: key);
  String title;
  String body;
  bool withLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            color:const Color(0xff232323),
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          body,
          style: GoogleFonts.roboto(
            color:const Color(0xff626262),
            fontSize: 14.sp,
            decoration: withLine ? TextDecoration.lineThrough : TextDecoration.none,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}