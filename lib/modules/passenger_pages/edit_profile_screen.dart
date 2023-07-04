// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:twsela/components/default_app_bar.dart';
//
//
// class EditProfileScreen extends StatelessWidget {
//   EditProfileScreen({Key? key}) : super(key: key);
//
//   var nationalIdController = TextEditingController();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var departmentController = TextEditingController();
//   var nameController = TextEditingController();
//   var ensurePasswordController = TextEditingController();
//   double verticalPaddingOfTFF = 8;
//   double horizontalPaddingOfTFF = 8;
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DefaultAppBar(
//         title: 'تعديل الصفحة',
//         withLeadingButton: true,
//         leadingFunction: (){
//           Navigator.pop(context);
//         },
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0.w),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 77.w,
//                         backgroundColor: Colors.white,
//                         child: CircleAvatar(
//                           radius: 75.w,
//                          // backgroundImage: AssetImage('${imagePath}images/offer1.jpg',),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 9.h,
//                         right: 9.h,
//                         child: CircleAvatar(
//                             radius: 13.w,
//                             backgroundColor: Colors.black,
//                             child: Icon(Icons.add, color: Colors.white,size: 20.w,)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4.h,),
//               Align(
//                 alignment: AlignmentDirectional.center,
//                 child: Text(
//                   'محمد ناصر',
//                   style: TextStyle(
//                     fontSize: 26.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 10.h,),
//              // TFFHeader(text: 'الاسم'),
//               DefaultTextFormField(
//                 context: context,
//                 controller: nameController,
//                 hintColor: Colors.grey,
//                 withBorder: true,
//                 focusBorderColor: Colors.black,
//                 inputType: TextInputType.text,
//                 enabledBorderColor: Colors.black,
//                 verticalPadding: verticalPaddingOfTFF,
//                 horizontalPadding: horizontalPaddingOfTFF,
//                 color: Colors.transparent,
//                 validator: (value){
//
//                 },
//                 text: '',
//               ),
//
//               SizedBox(height: 10.h,),
//               TFFHeader(text: 'البريد الالكتروني'),
//               DefaultTextFormField(
//                 context: context,
//                 controller: emailController,
//                 hintColor: Colors.grey,
//                 withBorder: true,
//                 focusBorderColor: Colors.black,
//                 inputType: TextInputType.emailAddress,
//                 enabledBorderColor: Colors.black,
//                 verticalPadding: verticalPaddingOfTFF,
//                 horizontalPadding: horizontalPaddingOfTFF,
//                 color: Colors.transparent,
//                 validator: (value){
//
//                 },
//                 text: '',
//               ),
//
//               SizedBox(height: 10.h,),
//               TFFHeader(text:  'كلمة السر'),
//               DefaultTextFormField(
//                 context: context,
//                 controller: passwordController,
//                 hintColor: Colors.grey,
//                 withBorder: true,
//                 focusBorderColor: Colors.black,
//                 inputType: TextInputType.text,
//                 enabledBorderColor: Colors.black,
//                 verticalPadding: verticalPaddingOfTFF,
//                 horizontalPadding: horizontalPaddingOfTFF,
//                 color: Colors.transparent,
//                 validator: (value){
//                   if(value!.isEmpty) return 'ادخل اسم الطالب';
//                   return null;
//                 },
//                 text: '',
//               ),
//
//               SizedBox(height: 10.h,),
//               TFFHeader(text:  'الرقم القومي'),
//               DefaultTextFormField(
//                 context: context,
//                 controller: nationalIdController,
//                 hintColor: Colors.grey,
//                 withBorder: true,
//                 focusBorderColor: Colors.black,
//                 inputType: TextInputType.number,
//                 enabledBorderColor: Colors.black,
//                 verticalPadding: verticalPaddingOfTFF,
//                 horizontalPadding: horizontalPaddingOfTFF,
//                 color: Colors.transparent,
//                 validator: (value){
//                   if(value!.isEmpty) return 'ادخل اسم الطالب';
//                   return null;
//                 },
//                 text: '',
//               ),
//
//               SizedBox(height: 10.h,),
//               TFFHeader(text:   'الشعبة'),
//               DefaultTextFormField(
//                 context: context,
//                 controller: departmentController,
//                 hintColor: Colors.grey,
//                 withBorder: true,
//                 focusBorderColor: Colors.black,
//                 inputType: TextInputType.text,
//                 enabledBorderColor: Colors.black,
//                 verticalPadding: verticalPaddingOfTFF,
//                 horizontalPadding: horizontalPaddingOfTFF,
//                 color: Colors.transparent,
//                 validator: (value){},
//                 text: '',
//               ),
//               SizedBox(height: 26.h,),
//
//               Align(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: customButton(
//                   text: 'حفظ البيانات',
//                   elevation: 0.0,
//                   height: 38.h,
//                   textColor: Colors.black.withOpacity(0.8),
//                   color: Colors.white,
//                   width: MediaQuery.of(context).size.width*0.4,
//                   function: (){},
//                 ),
//               ),
//               SizedBox(height: 36.h,),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
