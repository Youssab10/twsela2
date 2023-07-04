import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:twsela/components/constants.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';

import '../../components/core_components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'new_promotion.dart';

class DriverMakePromotion extends StatefulWidget {
  const DriverMakePromotion({Key? key}) : super(key: key);

  @override
  State<DriverMakePromotion> createState() => _DriverMakePromotionState();
}

class _DriverMakePromotionState extends State<DriverMakePromotion> {
var controller = TextEditingController();

var userId = '';
bool isLoading = false;
Future onSearch() async
{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  setState((){
    isLoading = true;
  });
  await firestore.collection('users')
      .where('email'  , isEqualTo: controller.text)
  .get().then((value) => {

      setState(() {

    AppCubit
        .get(context)
        .userMap = value.docs[0].data();
    isLoading = false;

      }),

  print(AppCubit.get(context).userMap),
  userId = AppCubit.get(context).userMap['uId'],
  print(userId) ,

  }).catchError((error)
  {
    print('there is no user with that email');
    print(error.toString());
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: controller,
              validator: (String? str) {  },
              onFieldSubmitted: (value)
              {
                onSearch();
              },

              onChanged: (value )
              {
                onSearch();

              },
              decoration:  InputDecoration(
                border: OutlineInputBorder
                  (
                  borderRadius: BorderRadius.circular(20),
                ),

                 suffixIcon : const Icon(Icons.search),

               labelText   : 'Search here by Email..',
              ),


            ),
          ),
          OutlinedButton(onPressed: (){

            onSearch();

          }, child: Text('Search')),
      if(AppCubit.get(context).userMap['type'] == 'passenger')   InkWell(
          onTap: ()
          {
            navigateTo(context, NewPromotion());

          },
          child:

    ListTile(
    title: Text(AppCubit.get(context).userMap['name'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    subtitle: Text(AppCubit.get(context).userMap['email']),
    leading: Image.asset('assets/images/person.jpg',
    height: 40,

    ),
    ) ,
        )
    else if (controller.text == '') Container()
      else const Center(child: Text('There is no passenger with that Email'))
       ],
      ),


    );
  }
}
