

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twsela/components/custom_button.dart';
import 'package:twsela/components/default_app_bar.dart';
import 'package:twsela/shared/network/local/cache_helper.dart';

import '../../components/constants.dart';
import '../../layout/cubit/app_cubit.dart';
import '../../layout/cubit/shop_states.dart';


class EditScreen extends  StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();


  void initControllers(){
    emailController.text= CacheHelper.getData(key: 'email');
    nameController.text= CacheHelper.getData(key: 'name');
    phoneController.text= CacheHelper.getData(key: 'phone');
    addressController.text= CacheHelper.getData(key: 'address');
  }


  @override
  Widget build(BuildContext context) {
    initControllers();

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: DefaultAppBar(
            title: 'Update Profile',
            leadingFunction: (){
              Navigator.pop(context);
            },
            withLeadingButton: true,

          ),
          body:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your name';
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your phone';
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',

                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter email address';
                          }
                          else {
                            return null;
                          }
                        },
                      ),

                      SizedBox(height: 20.0,),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          prefixIcon: Icon(
                            Icons.location_on_sharp,
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Address';
                          }
                          else {
                            return null;
                          }
                        },
                      ),


                      SizedBox(height: 50.0,),
                      ConditionalBuilder(
                        condition: state is UpdateUserLoadingState,
                        builder: (context)=> Container(
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: secondaryColor,
                          ),
                          child: const Center(child: CircularProgressIndicator(color: Colors.white,),),
                        ),
                        fallback:(context)=> CustomButton(
                          text: 'Update',
                          radius: 12,
                          height: 40.h,
                          color: secondaryColor,
                          function: (){
                            if(formKey.currentState!.validate()) {
                              AppCubit.get(context).updateUser(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  address: addressController.text.trim());
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
