

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twsela/components/constants.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';
import 'package:twsela/layout/cubit/shop_states.dart';


class DriverHomeLayout extends  StatelessWidget {
  const DriverHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.driverBodyScreens[cubit.driverCurrentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: secondaryColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index){
                cubit.changeDriverBottomNavBarItem(index);
              },
              currentIndex: cubit.driverCurrentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon:Icon(Icons.location_on_sharp,),
                  label: 'Map'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.file_copy_sharp,),
                    label: 'My Trips'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.settings,),
                    label: 'Settings'
                ),
              ],
            ),
          );
        },
    );
  }
}
