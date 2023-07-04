import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';


class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{

  Function leadingFunction;
  Function? drawerFunction;
  String title;
  bool withDrawer;
  bool withLeadingButton;
  Color appBarColor;
  Widget? actionWidget;

   DefaultAppBar({Key? key,
     required this.title,
     this.withDrawer=false,
     this.actionWidget=null,
     this.withLeadingButton=false,
     required this.leadingFunction,
     this.appBarColor=secondaryColor,
     this.drawerFunction,
   }) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: appBarColor,
      centerTitle: true,
      leading: withLeadingButton? IconButton(onPressed: (){leadingFunction();}, icon: Icon(Icons.arrow_back_ios_rounded)) : null,
      /*
      withDrawer==true ? IconButton(
          icon: SvgPicture.asset('$imagePath/icons/drawer_icon.svg'),
        onPressed: (){
            drawerFunction!();
        },
      ) : null,
      */
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
      ],
    );
  }



  @override
  final Size preferredSize;
}
