

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/components/custom_button.dart';
import '../../layout/home_layout.dart';
import '../driver_modules/driver_home_layout.dart';
import '../register_screen/passenger_register_screen.dart';
import 'login_cubit.dart';
import 'login_states.dart';

class LoginScreen extends  StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state){
          if(state is LoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }else if(state is LoginSuccessState){
            showToast(text: 'Login Successfully', state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state){
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Image.asset(
                         'assets/images/Logo2.png',
                         width: 250.w,
                         height: 250.w,
                       ),
                        TextFormField(
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
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon:const Icon(
                               Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                LoginCubit.get(context).changePassword();
                              },
                              icon: Icon(
                                LoginCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          obscureText:LoginCubit.get(context).isShown ? false : true,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30.0,),
                        Container(
                          width: double.infinity,
                          height: 45.h,
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder:(context)=> MaterialButton(
                              color: Color(0xff0e335f),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onPressed:(){
                                LoginCubit.get(context).login(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    context: context);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            fallback:(context)=> const Center(child: CircularProgressIndicator(color: secondaryColor,)) ,
                          ),



                        ),

                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'If you don\'t have an account! ',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              child:const Text(
                                  'Click Here'
                              ),
                              onPressed: (){
                                navigateTo(context, PassengerRegisterScreen());
                                //choseUserTypeDialog(context: context, function: (){});
                              },
                            ),
                          ],
                        ),
                      ],
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
