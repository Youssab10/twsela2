

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/components/custom_button.dart';
import 'package:twsela/modules/register_screen/register_cubit.dart';
import 'package:twsela/modules/register_screen/register_states.dart';

import '../../components/core_components.dart';



class PassengerRegisterScreen extends  StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }else if(state is CreateUserSuccessState){
            showToast(text: 'Signed up Successfully', state: ToastStates.SUCCESS);
          }
        },
        builder: (context,state){
          RegisterCubit cubit= RegisterCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 38.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),

                          const SizedBox(height: 40.0,),
                          TextFormField(
                            keyboardType: TextInputType.text,
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
                                return 'Enter name';
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 25.0,),
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
                          const SizedBox(height: 25.0,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
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
                          const SizedBox(height: 25.0,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: addressController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                              prefixIcon: Icon(
                                Icons.home_filled,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter your address';
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 25.0,),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon:const Icon(
                                Icons.lock_outline_rounded,
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  RegisterCubit.get(context).changePassword();
                                },
                                icon: Icon(
                                  RegisterCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            obscureText:RegisterCubit.get(context).isShown ? false : true,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter password';
                              }else if(passwordController.text.trim().length<6){
                                return 'Password must be at least 6 characters';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 25.0,),
                          TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Confirm Password',
                              prefixIcon:const Icon(
                                Icons.lock_outline_rounded,
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  RegisterCubit.get(context).changePassword();
                                },
                                icon: Icon(
                                  RegisterCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            obscureText:RegisterCubit.get(context).isShown ? false : true,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter password';
                              }else if(confirmPasswordController.text.trim().length<6){
                                return 'Password must be at least 6 characters';
                              }else if(passwordController.text.trim()!=confirmPasswordController.text.trim()){
                                return 'Not the same password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          BlocConsumer<RegisterCubit, RegisterStates>(
                            listener: (context, state){},
                            builder: (context, state) {
                              RegisterCubit cubit = RegisterCubit.get(context);
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: secondaryColor,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: cubit.accountType[0],
                                        groupValue: cubit.currentOption,
                                        onChanged: (value){
                                          cubit.changeAccountType(value.toString());
                                        },
                                      ),
                                      Text('Passenger',
                                      style: GoogleFonts.roboto(
                                        color: secondaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                    ],

                                  ),

                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: secondaryColor,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: cubit.accountType[1],
                                        groupValue: cubit.currentOption,
                                        onChanged: (value){
                                          cubit.changeAccountType(value.toString());
                                        },
                                      ),
                                      Text('Driver',
                                        style: GoogleFonts.roboto(
                                          color: secondaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                    ],

                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 30.0,),
                          Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: 40,
                            child: ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder:(context)=> CustomButton(
                                text: 'Register',
                                radius: 12,
                                color: secondaryColor,
                                height: 40.h,
                                textColor: Colors.white,
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userRegister(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                        name: nameController.text.trim(),
                                        phone: phoneController.text.trim(),
                                        address: addressController.text.trim(),
                                        type: cubit.currentOption== 'user' ?'passenger' : 'driver',
                                        context: context);
                                  }
                                },
                              ),
                              fallback:(context)=>const Center(child: CircularProgressIndicator(color: secondaryColor,)) ,
                            ),
                          ),
                          const SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account! ',
                              ),
                              TextButton(
                                child:const Text(
                                    'Login'
                                ),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30.0,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
