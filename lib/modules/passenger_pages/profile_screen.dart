import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/components/custom_button.dart';
import 'package:twsela/components/default_app_bar.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';
import 'package:twsela/layout/cubit/shop_states.dart';
import 'package:twsela/modules/login_screen/login_screen.dart';
import 'package:twsela/modules/passenger_pages/promotions_screen.dart';
import 'package:twsela/shared/network/local/cache_helper.dart';
import '../../components/core_components.dart';
import '../driver_modules/driver_make_promotions.dart';
import 'edit_profile_screen.dart';
import 'edit_screen.dart';
import 'my_trips_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: secondaryColor,
            //centerTitle: true,
            title: Text(
              'Profile',
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 28,
                  ))
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: size.height * 0.25,
                    width: double.infinity,
                    color: secondaryColor,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              height: size.height * 0.20.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400]!,
                                      spreadRadius: 1.0,
                                      offset: const Offset(2.0, 2.0),
                                      blurRadius: 1.0),
                                  BoxShadow(
                                      color: Colors.grey[400]!,
                                      spreadRadius: 1.0,
                                      offset: const Offset(-2.0, -2.0),
                                      blurRadius: 1.0),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 55.h,
                                  ),
                                  Text(
                                    cubit.userModel.name!,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Divider(color: Colors.grey[300], height: 2),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TabItem(
                                              header: 'Personal Info',
                                              isSelected:
                                                  cubit.profileIndex == 0
                                                      ? true
                                                      : false,
                                              function: () {
                                                cubit.changeProfileIndex(0);
                                              })),
                                      Expanded(
                                          child: TabItem(
                                              header: 'Settings',
                                              isSelected:
                                                  cubit.profileIndex == 1
                                                      ? true
                                                      : false,
                                              function: () {
                                                cubit.changeProfileIndex(1);
                                              })),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 51.5.w,
                          backgroundColor: secondaryColor,
                          child: CircleAvatar(
                            radius: 48.w,
                            backgroundImage: AssetImage(
                              'assets/images/person.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ConditionalBuilder(
                      condition: cubit.profileIndex == 0,
                      builder: (context) => Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.email_rounded,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    cubit.userModel.email!,
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                      color: const Color(0xff2F2E2E),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 22.0.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    cubit.userModel.phone!,
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                      color: const Color(0xff2F2E2E),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 22.0.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    cubit.userModel.address!,
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                      color: const Color(0xff2F2E2E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      fallback: (context) => Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                if (CacheHelper.sharedPreferences
                                        .getString('user_type') !=
                                    'driver')
                                  ProfileButton(
                                      icon: Icons.file_copy_sharp,
                                      text: 'My Trips',
                                      function: () {
                                        navigateTo(context, MyTripsScreen());
                                      }),
                                if (CacheHelper.sharedPreferences
                                        .getString('user_type') !=
                                    'driver')
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                if (CacheHelper.sharedPreferences
                                        .getString('user_type') !=
                                    'driver')
                                  ProfileButton(
                                      icon: Icons.discount,
                                      text: 'My Promotions',
                                      function: () {
                                        navigateTo(context, PromotionsScreen());
                                      }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ProfileButton(
                                    icon: Icons.mode_edit_outline_rounded,
                                    text: 'Edit Profile',
                                    function: () {
                                      navigateTo(context, EditScreen());
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                if (CacheHelper.sharedPreferences
                                        .getString('user_type') ==
                                    'driver')
                                  ProfileButton(
                                      text: 'Make Promotions',
                                      icon: Icons.arrow_circle_up_sharp,
                                      function: () {
                                        return navigateTo(
                                            context, DriverMakePromotion());
                                      }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ProfileButton(
                                    icon: Icons.logout,
                                    text: 'Log out',
                                    function: () {
                                      CacheHelper.removeData(key: 'name');
                                      CacheHelper.removeData(key: 'email');
                                      CacheHelper.removeData(key: 'uId');
                                      CacheHelper.removeData(key: 'phone');
                                      CacheHelper.removeData(key: 'address');
                                      navigateWithoutBack(
                                          context, LoginScreen());
                                    }),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try {
                dynamic conversationObject = {
                  'appId': '3241942ba7aa460736518375975fbefbb'
                };
                dynamic result =
                    await KommunicateFlutterPlugin.buildConversation(
                        conversationObject);
                print("Conversation builder success : " + result.toString());
              } on Exception catch (e) {
                print("Conversation builder error occurred : " + e.toString());
              }
            },
            backgroundColor: secondaryColor,
            child: Icon(
              Icons.support_agent_rounded,
              size: 32.r,
            ),
          ),
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.function})
      : super(key: key);
  final Function function;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: double.infinity,
        height: 65.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            const BoxShadow(
                color: Colors.white,
                spreadRadius: 1.0,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0),
            BoxShadow(
                color: Colors.grey[300]!,
                spreadRadius: 1.0,
                offset: const Offset(-2.0, -2.0),
                blurRadius: 4.0),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/profile.jpg',
            //   width: 30,
            //   height: 30,
            // ),
            Icon(
              icon,
              color: secondaryColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: const Color(0xff2F2E2E),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Color(0xff1D592C),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  SettingButton({
    Key? key,
    required this.icon,
    required this.text,
    this.isDelete = false,
    required this.function,
  }) : super(key: key);

  String text;
  Function function;
  IconData icon;
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: MaterialButton(
        height: 50.h,
        elevation: 0.0,
        onPressed: () {
          function();
        },
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: 24.w,
                )),
            SizedBox(
              width: 12.w,
            ),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
            CircleAvatar(
                radius: 12.w,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16.w,
                )),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  TabItem({
    Key? key,
    required this.header,
    required this.isSelected,
    required this.function,
  }) : super(key: key);

  String header;
  bool isSelected;
  Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? secondaryColor.withOpacity(0.7)
                    : Colors.grey[300]!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              header,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: isSelected ? secondaryColor : Colors.grey[600],
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
