
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize=16,
    this.textColor=Colors.lightBlueAccent,
    this.icon=null ,

  }) : super(key: key);

  String text;
  Function onPressed;
  double fontSize=16;
  Color textColor=Colors.lightBlueAccent;
  Widget? icon=null ;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(foregroundColor : MaterialStateProperty.all<Color>(textColor)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(icon!=null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon!,
            ),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: textColor,
              fontSize: fontSize.sp,
            ),
          ),

        ],
      ),
      onPressed: (){
        onPressed();
      },
    );
  }
}
