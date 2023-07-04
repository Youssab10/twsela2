import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:twsela/components/constants.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/components/custom_button.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';
import 'package:twsela/layout/cubit/shop_states.dart';
import 'package:twsela/modules/driver_modules/driver_trips_screen.dart';

import '../../components/default_app_bar.dart';
import 'location/map_screen.dart';

bool fromChecker = false;
bool toChecker = false;

class NewTripScreen extends StatelessWidget {
  NewTripScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: DefaultAppBar(
            title: 'New Trip',
            withLeadingButton: true,
            leadingFunction: () {
              navigateTo(context, DriverTripsScreen());
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        fromChecker = true;
                        navigateTo(context, MapScreens());
                      },
                      child: Container(
                        child: TextFormField(
                          controller: cubit.fromController,
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            border: OutlineInputBorder(),
                            enabled: false,
                            labelText: 'From',
                            prefixIcon: Icon(
                              Icons.location_pin,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Location';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    InkWell(
                      onTap: () {
                        toChecker = true;
                        navigateTo(context, MapScreens());
                      },
                      child: Container(
                        child: TextFormField(
                          controller: cubit.toController,
                          decoration: const InputDecoration(
                            enabled: false,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'To',
                            prefixIcon: Icon(
                              Icons.location_pin,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Location';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    TextFormField(
                        controller: cubit.passengersNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number Of Passengers',
                          prefixIcon: Icon(
                            Icons.group_add,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Number Of Passengers';
                          } else if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          } else if (int.parse(value) > 6) {
                            return 'Number of passengers less than 7';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 26.h,
                    ),
                    TextFormField(
                      controller: cubit.timeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Start Time',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              cubit.timeController.text =
                                  picked.format(context).toString();
                            }
                          },
                          icon: Icon(Icons.access_time),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Start Time';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    TextFormField(
                      controller: cubit.dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Trip Date',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024),
                            );
                            if (picked != null) {
                              cubit.dateController.text =
                                  picked.toString().substring(0, 10);
                            }
                          },
                          icon: Icon(Icons.date_range),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Date';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    TextFormField(
                      controller: cubit.priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Price';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45.h,
                      child: ConditionalBuilder(
                        condition: state is! AddTripLoadingState,
                        builder: (context) => CustomButton(
                            text: 'Save',
                            height: 35.h,
                            radius: 6,
                            fontSize: 18,
                            color: secondaryColor,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addTrip();
                              }
                            }),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) {
    print('Selected time: ${picked.format(context)}');
  }
}
