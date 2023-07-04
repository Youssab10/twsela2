
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/modules/driver_modules/all_driver_info.dart';
import 'package:twsela/modules/register_screen/passenger_register_screen.dart';

import 'custom_button.dart';





Future<dynamic> navigateWithoutBack(context,Widget widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false
);


Future<dynamic> navigateTo(context,Widget widget)=>Navigator.push(context,
  MaterialPageRoute(builder: (context)=>widget),
);


Widget CustomTextFormField({
  required TextEditingController controller,
  required String ?validator(String ? str),
  IconData ? icon,
  IconData ? prefixIcon,
  String ? text,
  Color color =Colors.white,
  bool withBorder =true,
  bool isDescription =false,
  bool isPassword =false,
  bool isSecured =false,
  double radius=100,
  bool isEnabled=true,
  Color hintColor = Colors.grey,
  Color enabledBorderColor = Colors.lightBlueAccent,
  double height=53,
  required context,
  Function ? suffixIconPressed,
  double verticalPadding=0,
  double horizontalPadding=0,
  TextInputType inputType =TextInputType.text,
})=>Container(
  //height: height.h,
  alignment: Alignment.bottomCenter,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  ),
  child: Center(
    child: TextFormField(
      enabled:isEnabled ? true: false,
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      validator: validator,
      maxLines:isDescription ? 7:1,
      obscureText:isSecured ? true: false,
      keyboardType: inputType,
      decoration: InputDecoration(
        isDense: true,
        hintText: text,
        hintStyle: GoogleFonts.poppins(
          color: hintColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: verticalPadding.h,horizontal: horizontalPadding.w),
        prefixIcon:prefixIcon==null ? null : Icon(prefixIcon),
        prefixIconConstraints: BoxConstraints(maxHeight: 30.h,minWidth: 32.w),
        suffixIcon:icon==null ? null : Icon(icon, color: Colors.lightBlueAccent,),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(radius)),
                borderSide:const BorderSide(color: Colors.lightBlueAccent),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(radius)),
                borderSide: BorderSide(color:withBorder ? enabledBorderColor : color),
        ),
      ),
    ),
  ),
);


















Future<dynamic> goToDriverInfoDialog({
  required context,
}) => showDialog(
  context: context,
  builder: (context){
    return AlertDialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: const EdgeInsets.all(0.0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  'You must complete your information to be able to add trip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff173F55),
                    fontSize: 20.sp,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Back',
                        color:  secondaryColor,
                        height: 40.h,
                        radius: 12.r,
                        textColor: Colors.white,
                        function: (){
                          Navigator.pop(context);

                        },
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: CustomButton(
                        text: 'Ok',
                        color:  secondaryColor,
                        height: 40.h,
                        radius: 12.r,
                        textColor: Colors.white,
                        function: (){
                          Navigator.pop(context);
                          navigateTo(context, AllDriverInfoScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
);



enum ToastStates{ERROR,SUCCESS,WARNING}

Color choseToastState(ToastStates state){

  Color color;
  switch(state){
    case ToastStates.SUCCESS: color=Colors.green;
    break;
    case ToastStates.ERROR: color=Colors.red;
    break;
    case ToastStates.WARNING: color=Colors.amber;
    break;
  }
  return color;
}

void showToast({
  required String? text,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg:text ?? 'Error',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastState(state),
    textColor: Colors.white,
    fontSize: 16.0
);


