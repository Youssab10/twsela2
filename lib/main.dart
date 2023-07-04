

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:twsela/components/core_components.dart';

import 'package:twsela/modules/driver_modules/driver_home_layout.dart';
import 'package:twsela/modules/login_screen/login_screen.dart';
import 'package:twsela/shared/network/local/cache_helper.dart';
import 'layout/cubit/app_cubit.dart';
import 'layout/home_layout.dart';
import 'modules/driver_modules/location/location_controller.dart';


Future<void> backgroundMessages(RemoteMessage message) async
{
   print(message.data.toString());
   showToast(text: 'One message sends to you !',
       state: ToastStates.SUCCESS);

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(LocationController());
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
   print(event.data.toString());
   showToast(text: 'One message sends to you !',
       state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'One message sends to you !',
        state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(backgroundMessages);

  
  await CacheHelper.init();
  String? uId = CacheHelper.getData(key: 'uId');
  String? type = CacheHelper.getData(key: 'type');

  FirebaseMessaging.onMessage.listen((event) {
    print('ffffffffff');
  });

  Widget startWidget;
  if(uId!=null){
    if(type=='driver'){
      startWidget= DriverHomeLayout();
    }else{
      startWidget= HomeLayout();
    }
  }else{
    startWidget= LoginScreen();
  }


  runApp(MyApp(widget: startWidget,));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.widget}) : super(key: key);
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return BlocProvider(
          create: (context)=>AppCubit()..getUserData(),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
          ),
        );
      },
      child: widget,
    );
  }
}
