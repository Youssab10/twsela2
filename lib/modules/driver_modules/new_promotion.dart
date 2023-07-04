import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/modules/driver_modules/driver_make_promotions.dart';
import 'package:twsela/modules/driver_modules/driver_trips_screen.dart';

import '../../components/custom_button.dart';
import '../../components/default_app_bar.dart';
import '../../layout/cubit/app_cubit.dart';
import '../../layout/cubit/shop_states.dart';
import '../../models/promotions_model.dart';

class NewPromotion extends StatelessWidget {
  NewPromotion({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: DefaultAppBar(
              title: 'Make a promotion',
              withLeadingButton: true,
              leadingFunction: () {
                Navigator.pop(context);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 26.h,
                      ),
                      TextFormField(
                        controller: cubit.discountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Discount',
                          prefixIcon: Icon(
                            Icons.discount,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Discount';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 45.h,
                        child: CustomButton(
                            text: 'Save',
                            height: 35.h,
                            radius: 6,
                            fontSize: 18,
                            color: secondaryColor,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addPromotion();

                                cubit.getAllPromotions();
                                print('yes');
                                navigateTo(context, DriverMakePromotion());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
