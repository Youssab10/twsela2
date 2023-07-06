import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/components/custom_button.dart';
import 'package:twsela/components/default_app_bar.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';
import 'package:twsela/layout/cubit/shop_states.dart';
import 'package:twsela/models/trip_model.dart';
import 'package:twsela/modules/driver_modules/all_driver_info.dart';
import 'package:twsela/modules/screens/map/view.dart';
import 'package:twsela/shared/network/local/cache_helper.dart';
import '../../components/user_info_item.dart';
import 'new_trip.dart';

class DriverTripsScreen extends StatelessWidget {
  const DriverTripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getDriverTrips();
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              appBar: DefaultAppBar(
                title: 'My Trips',
                leadingFunction: () {},
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: ConditionalBuilder(
                  condition: cubit.driverTrips.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => MyTripsCart(
                        index: index, trip: cubit.driverTrips[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                    itemCount: cubit.driverTrips.length,
                  ),
                  fallback: (context) => Center(
                    child: Text(
                      'You do not have any trips yet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (CacheHelper.sharedPreferences
                          .getString('isDriverCompleteData') ==
                      'false') {
                    goToDriverInfoDialog(context: context);
                  } else {
                    navigateTo(context, NewTripScreen());
                  }
                },
                backgroundColor: secondaryColor,
                child: Icon(
                  Icons.add,
                  size: 32.r,
                ),
              ));
        },
      );
    });
  }
}

class MyTripsCart extends StatelessWidget {
  MyTripsCart({Key? key, required this.trip, required this.index})
      : super(key: key);
  int index;
  TripModel trip;
  Color getColor() {
    if (index % 2 == 0)
      return Color(0xff14A38B);
    else
      return Color(0xffFF9494);
  }

  String getTitle() {
    if (index % 2 == 0)
      return 'Done';
    else
      return 'Canceled';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: getColor(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getTitle(),
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 9.sp,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.timelapse,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${trip.passengersNumbersLogin}/${trip.passengersNumbers}',
                  style: GoogleFonts.roboto(
                    color: secondaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomButton(
                    text: 'Start',
                    height: 23.h,
                    width: 80.w,
                    radius: 6,
                    fontSize: 14,
                    color: secondaryColor,
                    function: () {
                      navigateTo(context, MyMap());
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInfoItem(title: 'Driver', body: trip.driverName!),
                        SizedBox(
                          height: 10.h,
                        ),
                        UserInfoItem(
                            title: 'Phone Number',
                            body: CacheHelper.getData(key: 'phone')!),
                        SizedBox(
                          height: 10.h,
                        ),
                        UserInfoItem(title: 'Time', body: trip.time!),
                        SizedBox(
                          height: 10.h,
                        ),
                        UserInfoItem(title: 'Date', body: trip.date!),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UserInfoItem(title: 'Trip Code', body: trip.tripCode!),
                        SizedBox(
                          height: 10.h,
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          itemSize: 20.sp,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 10,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '${trip.price!}\$',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.brown,
                          ),
                          Text(
                            'TO',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: Colors.black),
                          ),
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              trip.from!,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              trip.to!,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
