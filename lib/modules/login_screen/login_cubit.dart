


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';
import 'package:twsela/layout/home_layout.dart';
import 'package:twsela/modules/driver_modules/driver_home_layout.dart';
import 'package:twsela/shared/network/local/cache_helper.dart';
import '../../models/models.dart';
import 'login_states.dart';

class LoginCubit extends Cubit <LoginStates>{
  LoginCubit():super(LoginInitialState());


  static LoginCubit get(context)=> BlocProvider.of(context);

  late ShopLoginModel loginModel;



  bool isShown = false;
  void changePassword(){
    isShown=!isShown;
    emit(LoginChangeState());
  }

  void login({
    required String email,
    required String password,
    required context,
  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      FirebaseFirestore.instance.collection('users')
          .doc(value.user!.uid).get().then((value) {
        CacheHelper.saveData(key: 'name', value: value.get('name').toString());
        CacheHelper.saveData(key: 'phone', value: value.get('phone').toString());
        CacheHelper.saveData(key: 'email', value: value.get('email').toString());
        CacheHelper.saveData(key: 'address', value: value.get('address').toString());
        CacheHelper.saveData(key: 'type', value: value.get('type').toString());

        AppCubit.get(context).getUserData();
        if(value.get('type').toString()=='driver'){
          CacheHelper.sharedPreferences.setString('user_type', 'driver');
          navigateWithoutBack(context, DriverHomeLayout());
        }else{
          CacheHelper.sharedPreferences.setString('user_type', 'passenger');
          navigateWithoutBack(context, HomeLayout());
        }
      });
      emit(LoginSuccessState());
    }).catchError((error){
      List<String>err= error.toString().split(']');
      emit(LoginErrorState(err.last));
    });

  }


}