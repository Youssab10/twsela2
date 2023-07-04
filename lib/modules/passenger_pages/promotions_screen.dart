
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twsela/components/default_app_bar.dart';
import 'package:twsela/layout/cubit/app_cubit.dart';
import 'package:twsela/layout/cubit/shop_states.dart';
import 'package:twsela/models/promotions_model.dart';
import '../../components/constants.dart';
import '../../components/user_info_item.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getAllPromotions();
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){},
          builder: (context, state){
            AppCubit cubit= AppCubit.get(context);
            return Scaffold(
              appBar: DefaultAppBar(
                title: 'Promotions',
                leadingFunction: (){},
              ),

              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: ConditionalBuilder(
                  condition: cubit.allPromotions.isNotEmpty,
                  builder:(context)=> ListView.separated(
                    itemBuilder: (context, index)=>PromotionsCart(
                        index: index,
                        promotionsModel: cubit.allPromotions[index]),
                    separatorBuilder: (context, index)=>SizedBox(height: 16.h,),
                    itemCount: cubit.allPromotions.length,
                  ),
                  fallback: (context)=> Center(
                    child: Text(
                      'You do not have any promotions yet',
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
            );
          },
        );
      }
    );
  }


}


class PromotionsCart extends StatelessWidget {
  PromotionsCart({Key? key, required this.index, required this.promotionsModel}) : super(key: key);
  int index;
  PromotionsModel promotionsModel;

  Color getColor(){
    if(int.parse(promotionsModel.discount!)>50&& int.parse(promotionsModel.discount!)<100) return Color(0xff8de39b);
    else if(int.parse(promotionsModel.discount!)>40&& int.parse(promotionsModel.discount!)<=50) return Color(0xff84d4e1);
    else if(int.parse(promotionsModel.discount!)>25&& int.parse(promotionsModel.discount!)<=4) return Color(0xfff8d691);
    else return Color(0xffFF9494);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      //elevation: 2.0,
      color: getColor(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserInfoItem(title: 'Code', body: promotionsModel.id == null ? 'no code' : promotionsModel.id! ),
                    UserInfoItem(title: 'Discount', body: '${promotionsModel.discount}%'),
                  ],
                ),
                SizedBox(height: 10.h,),
                UserInfoItem(title: 'Condition', body: promotionsModel.condition!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
