

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twsela/components/constants.dart';
import 'cubit/app_cubit.dart';
import 'cubit/shop_states.dart';

class HomeLayout extends  StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.bodyScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: secondaryColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index){
                cubit.changeBottomNavBarItem(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon:Icon(Icons.location_on_sharp,),
                  label: 'Map'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.file_copy_sharp,),
                    label: 'All Trips'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.discount,),
                    label: 'Promotions'
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
