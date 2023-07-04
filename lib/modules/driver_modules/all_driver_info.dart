import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/components/custom_button.dart';
import 'package:twsela/components/default_app_bar.dart';
import 'package:twsela/modules/register_screen/register_cubit.dart';
import 'package:twsela/modules/register_screen/register_states.dart';

class AllDriverInfoScreen extends StatelessWidget {
  AllDriverInfoScreen({Key? key}) : super(key: key);


  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
            leadingFunction: (){Navigator.pop(context);},
            withLeadingButton: true,
            title: 'All Driver Information'
          ),
      body: BlocProvider(
        create: (context)=> RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state){},
          builder: (context, state) {
            RegisterCubit cubit= RegisterCubit.get(context);

            return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h,),
                    Container(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width*0.6,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).userImage==null,
                        builder: (context)=> Image.asset('assets/images/profile.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).userImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Ad Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadUserImage();
                      },
                    ),



                    SizedBox(height: 30.h,),
                    Divider(height: 2.5,color: Colors.grey,),
                    SizedBox(height: 30.h,),
                    /// driver license info
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Driver License Number',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    CustomTextFormField(
                        controller: cubit.licenseNumberController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter license number';
                          } else {
                            return null;
                          }
                        },
                        context: context,
                        inputType: TextInputType.number,
                        height: 50.h,
                        verticalPadding: 12,
                        horizontalPadding: 12,
                        radius: 12,
                        text: 'License Number',
                        enabledBorderColor: Colors.grey
                    ),

                    SizedBox(height: 30.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Front Photo Of Driver\'s License',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).frontDriverLicenseImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=>  Image.file(RegisterCubit.get(context).frontDriverLicenseImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Add Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadFrontDriverLicenseImage();
                      },
                    ),
                    SizedBox(height: 40.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Back Photo Of Driver\'s License',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).backDriverLicenseImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).backDriverLicenseImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Add Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadBackDriverLicenseImage();
                      },
                    ),


                    SizedBox(height: 30.h,),
                    Divider(height: 2.5,color: Colors.grey,),
                    SizedBox(height: 30.h,),


                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Front Photo Of Driver\'s National Id',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).frontNationalIdImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).frontNationalIdImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Ad Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadFrontNationalIdImage();
                      },
                    ),
                    SizedBox(height: 40.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Back Photo Of Driver\'s National Id',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).backNationalIdImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).backNationalIdImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Ad Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadBackNationalIdImage();
                      },
                    ),


                    SizedBox(height: 30.h,),
                    Divider(height: 2.5,color: Colors.grey,),
                    SizedBox(height: 30.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Criminal Records Image',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).criminalRecordsImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).criminalRecordsImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),
                    CustomButton(
                      text: 'Ad Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadCriminalRecordsImage();
                      },
                    ),


                    SizedBox(height: 30.h,),
                    Divider(height: 2.5,color: Colors.grey,),
                    SizedBox(height: 30.h,),


                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Car Information',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    CustomTextFormField(
                        controller: cubit.carTypeController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter car type';
                          } else {
                            return null;
                          }
                        },
                        context: context,
                        height: 50.h,
                        verticalPadding: 12,
                        horizontalPadding: 12,
                        radius: 12,
                        text: 'Car Type',
                        enabledBorderColor: Colors.grey
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextFormField(
                        controller: cubit.carModelController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter car model';
                          } else {
                            return null;
                          }
                        },
                        context: context,
                        height: 50.h,
                        verticalPadding: 12,
                        inputType: TextInputType.text,
                        horizontalPadding: 12,
                        radius: 12,
                        text: 'Car Model',
                        enabledBorderColor: Colors.grey
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextFormField(
                        controller: cubit.carColorController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter car color';
                          } else {
                            return null;
                          }
                        },
                        context: context,
                        height: 50.h,
                        verticalPadding: 12,
                        horizontalPadding: 12,
                        inputType: TextInputType.text,
                        radius: 12,
                        text: 'Car Color',
                        enabledBorderColor: Colors.grey
                    ),


                    SizedBox(height: 20.h,),
                    CustomTextFormField(
                        controller: cubit.numberPlateController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter number of plate';
                          } else {
                            return null;
                          }
                        },
                        context: context,
                        inputType: TextInputType.text,
                        height: 50.h,
                        verticalPadding: 12,
                        horizontalPadding: 12,
                        radius: 12,
                        text: 'Plate Number',
                        enabledBorderColor: Colors.grey
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextFormField(
                        controller: cubit.transportYearController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter transport year';
                          } else {
                            return null;
                          }
                        },
                        context: context,
                        height: 50.h,
                        inputType: TextInputType.number,
                        verticalPadding: 12,
                        horizontalPadding: 12,
                        radius: 12,
                        text: 'Transport Year',
                        enabledBorderColor: Colors.grey
                    ),


                    SizedBox(height: 40.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Front Photo Of Car\'s License',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).frontCarLicenseImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).frontCarLicenseImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Add Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadFrontCarLicenseImage();
                      },
                    ),
                    SizedBox(height: 40.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Back Photo Of Car\'s License',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).backCarLicenseImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).backCarLicenseImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Add Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadBackCarLicenseImage();
                      },
                    ),


                    SizedBox(height: 40.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Photo Of Your Car',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ConditionalBuilder(
                        condition: RegisterCubit.get(context).carImage==null,
                        builder: (context)=> Image.asset('assets/images/certification.jpg', fit: BoxFit.cover,),
                        fallback: (context)=> Image.file(RegisterCubit.get(context).carImage!, fit: BoxFit.cover,),
                      ) ,
                    ),
                    SizedBox(height: 16.h,),

                    CustomButton(
                      text: 'Add Photo',
                      color: primaryColor,
                      radius: 12,
                      height: 40.h,
                      textColor: Colors.black,
                      elevation: 0.0,
                      function: (){
                        RegisterCubit.get(context).uploadCarImage();
                      },
                    ),

                    SizedBox(height: 70.h,),


                    Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 40,
                      child: ConditionalBuilder(
                        condition: state is! StoreDriverDataLoadingState,
                        builder:(context)=> CustomButton(
                          text: 'Save Data',
                          radius: 12,
                          color: secondaryColor,
                          height: 40.h,
                          textColor: Colors.white,
                          function: (){
                            if(cubit.userImage==null){
                              showToast(text: 'You must enter your image', state: ToastStates.WARNING);
                            }else if(cubit.frontDriverLicenseImage==null){
                              showToast(text: 'You must enter the front of your license image', state: ToastStates.WARNING);
                            } else if(cubit.backDriverLicenseImage==null){
                              showToast(text: 'You must enter the back of your license image', state: ToastStates.WARNING);
                            }else if(cubit.frontNationalIdImage==null){
                              showToast(text: 'You must enter the front of your national id image', state: ToastStates.WARNING);
                            }else if(cubit.backNationalIdImage==null){
                              showToast(text: 'You must enter the back of your national id image', state: ToastStates.WARNING);
                            }else if(cubit.criminalRecordsImage==null){
                              showToast(text: 'You must enter the back of your criminal records image', state: ToastStates.WARNING);
                            }else if(cubit.frontCarLicenseImage==null){
                              showToast(text: 'You must enter the front of car license image', state: ToastStates.WARNING);
                            } else if(cubit.backCarLicenseImage==null){
                              showToast(text: 'You must enter the back of car license image', state: ToastStates.WARNING);
                            }else if(cubit.carImage==null){
                              showToast(text: 'You must enter the car image', state: ToastStates.WARNING);
                            } else if(formKey.currentState!.validate()){
                              cubit.storeDriverData(context);
                            }
                          },
                        ),
                        fallback:(context)=>const Center(child: CircularProgressIndicator(color: secondaryColor,)) ,
                      ),
                    ),

                    SizedBox(height: 20.h,),

                  ],
                ),
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}
