
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twsela/layout/cubit/shop_states.dart';
import 'package:twsela/models/promotions_model.dart';
import 'package:twsela/models/user_model.dart';
import 'package:twsela/modules/driver_modules/driver_map_screen.dart';
import 'package:twsela/modules/driver_modules/driver_trips_screen.dart';
import 'package:twsela/shared/network/local/cache_helper.dart';
import '../../components/constants.dart';
import '../../components/core_components.dart';
import '../../models/trip_model.dart';
import '../../modules/passenger_pages/all_trips_screen.dart';
import '../../modules/passenger_pages/map_screen.dart';
import '../../modules/passenger_pages/profile_screen.dart';
import '../../modules/passenger_pages/promotions_screen.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit(): super (AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  List<Widget> bodyScreens=[
    MapScreen(),
    AllTripsScreen(),
    PromotionsScreen(),
    ProfileScreen(),
  ];

  List<Widget> driverBodyScreens=[
    DriverMapScreen(),
    DriverTripsScreen(),
    ProfileScreen(),
  ];

  int driverCurrentIndex=0;
  void changeDriverBottomNavBarItem(int index){
    driverCurrentIndex = index;
    emit(ChangeDriverBottomNavBarItemState());
  }


  int currentIndex=0;
  void changeBottomNavBarItem(int index){
    currentIndex = index;
    emit(ChangeBottomNavBarItemState());
  }


  int profileIndex=0;
  void changeProfileIndex(int index){
    profileIndex= index;
    emit(AppChangeProfileIndexState());
  }


  String? userNameInCubit  ;
  String ? userEmailInCubit;
  String ? userPhoneInCubit;



  var fromController = TextEditingController();
  var toController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var priceController = TextEditingController();
  var passengersNumberController = TextEditingController();


  var conditionController = TextEditingController();
  var discountController = TextEditingController();

  void addTrip(){
    String uId= CacheHelper.getData(key: 'uId');
    String name= CacheHelper.getData(key: 'name');
    emit(AddTripLoadingState());
    // Map<String, dynamic> trip= {
    //   'from': fromController.text.trim(),
    //   'to': toController.text.trim(),
    //   'time': timeController.text.trim(),
    //   'date': dateController.text.trim(),
    //   'price': priceController.text.trim(),
    // };
    CollectionReference collection = FirebaseFirestore.instance.collection('trips');
    DocumentReference newDocRef = collection.doc();
    TripModel tripModel= TripModel(
        driverName: name,
        date: dateController.text.trim(),
        time: timeController.text.trim(),
        driverUId: uId,
        passengersNumbersLogin: '0',
        from: fromController.text.trim(),
        to: toController.text.trim(),
        price: priceController.text.trim(),
        id: newDocRef.id,
        passengersNumbers: passengersNumberController.text.trim(),
        tripCode: '1252452',
        status: 'available',
    );

    FirebaseFirestore.instance.collection('trips').doc(tripModel.id).set(tripModel.toMap()).then((value) {
      removeControllers();
      emit(AddTripSuccessState());
    }).catchError((error){
      //List<String>err= error.toString().split(']');
      emit(AddTripErrorState());
    });
  }


  void removeControllers(){
    fromController.clear();
    toController.clear();
    timeController.clear();
    dateController.clear();
    priceController.clear();
    passengersNumberController.clear();
  }


  List<TripModel> driverTrips=[];
  void getDriverTrips(){
    driverTrips=[];
    String uId= CacheHelper.getData(key: 'uId');
    FirebaseFirestore.instance.collection('trips')
        //.orderBy('time')
        .where("driverUId", isEqualTo: uId)
        .snapshots()
        .listen((event) {

          driverTrips=[];
          event.docs.forEach((element) {
            driverTrips.add(TripModel.fromJson(element.data()));
          });
          emit(AppGetDriverTripsSuccessState());
    });
  }



  List<TripModel> allTrips=[];
  void getAllTrips(){
    allTrips=[];
    FirebaseFirestore.instance.collection('trips')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      allTrips=[];
      event.docs.forEach((element) {
        TripModel model= TripModel.fromJson(element.data());
        if(CacheHelper.getData(key: model.id!)!= null){
          model.isApplied= true;
        }
        allTrips.add(model);
      });
      emit(AppGetAllTripsSuccessState());
    });
  }


  List<TripModel> myTrips=[];
  void getMyTrips(){
    myTrips=[];
    FirebaseFirestore.instance.collection('users')
        .doc(userModel.uId).collection('userTrips')
        .snapshots()
        .listen((event) {
      myTrips=[];
      event.docs.forEach((element) {
        TripModel model= TripModel.fromJson(element.data());
        myTrips.add(model);
      });
      emit(AppMyTripsSuccessState());
    });
  }

  void cancelMyTrip(TripModel trip){

    FirebaseFirestore.instance.collection('trips')
        .doc(trip.id).collection('appliedUsers')
        .doc(userModel.uId).delete().then((value) {

      FirebaseFirestore.instance.collection('users')
          .doc(userModel.uId).collection('userTrips')
          .doc(trip.id).delete().then((value) {

        /// decrease number of passengers
        int passengers= int.parse(trip.passengersNumbersLogin!);
        passengers-=1;
        trip.passengersNumbersLogin= passengers <0? '0': passengers.toString();
        FirebaseFirestore.instance.collection('trips').doc(trip.id).update(trip.toMap());

            CacheHelper.removeData(key: trip.id!);
            showToast(text: 'Trip Canceled Successfully', state: ToastStates.WARNING);
            emit(CancelTripState());
      });
    });
  }

  List<PromotionsModel> allPromotions=[];
  void getAllPromotions(){

    allPromotions=[];


    FirebaseFirestore.instance.collection('promotions')
        .snapshots()
        .listen((event) {

      allPromotions=[];

      event.docs.forEach((element) {
        PromotionsModel promotion= PromotionsModel.fromJson(element.data());

        if(promotion.id == CacheHelper.getData(key: 'uId' ) && promotion.id != null){
          allPromotions.add(promotion);
          print('truuue');

        }
      });


      emit(AppGetAllPromotionsSuccessState());
    });
  }


  late UserModel userModel;
  Future<void> getUserData()async{
    userModel=UserModel(
        name:await CacheHelper.getData(key: 'name'),
        email:await CacheHelper.getData(key: 'email'),
        phone:await CacheHelper.getData(key: 'phone'),
        uId:await CacheHelper.getData(key: 'uId'),
        address:await CacheHelper.getData(key: 'address'),
        type:await CacheHelper.getData(key: 'type'),
    );
    emit(GetUserDataSuccessState());
  }


  void applyToTrip(TripModel trip){
    /// store trip in user
    FirebaseFirestore.instance.collection('users')
        .doc(userModel.uId)
        .collection('userTrips')
        .doc(trip.id)
        .set(trip.toMap()).then((value) {

          /// then store user in trip
      FirebaseFirestore.instance.collection('trips').doc(trip.id)
          .collection('appliedUsers').doc(userModel.uId).set(userModel.toMap()).then((value) {

            /// increase number of passengers
        int passengers= int.parse(trip.passengersNumbersLogin!);
        passengers+=1;
        trip.passengersNumbersLogin= passengers.toString();
        FirebaseFirestore.instance.collection('trips').doc(trip.id).update(trip.toMap());

        showToast(text: 'Trip added Successfully', state: ToastStates.SUCCESS);
        trip.isApplied=true;
        CacheHelper.saveData(key: trip.id!, value: true);
        emit(AddTripToUserSuccessState());
      });
    }).catchError((error){
      showToast(text: 'Try again', state: ToastStates.ERROR);
      emit(AddTripToUserErrorState());
    });
  }



  void updateUser({
  required String name,
  required String email,
  required String phone,
  required String address,
}){
    emit(UpdateUserLoadingState());
    UserModel user= UserModel(name: name, email: email, phone: phone, uId: CacheHelper.getData(key: 'uId'), address: address,type: CacheHelper.getData(key: 'type'),);
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'uId')).update(user.toMap()).then((value) {
      CacheHelper.saveData(key: 'name', value: user.name);
      CacheHelper.saveData(key: 'phone', value: user.phone);
      CacheHelper.saveData(key: 'email', value: user.email);
      CacheHelper.saveData(key: 'address', value: user.address);
      getUserData().then((value) {
        emit(UpdateUserSuccessState());
      });
    });


  }
  Map<String , dynamic> userMap ={};
  addPromotion ()
  {
    PromotionsModel promotionsModel = PromotionsModel
      (
     id: userMap['uId'],
      condition: conditionController.text,
      discount: discountController.text,
    );
    FirebaseFirestore.instance.collection('promotions').doc()
        .set(promotionsModel.toMap()).then((value)  {
          print(promotionsModel.toMap());
    }).catchError((error) {
      print('erorrrr${error.toString()}');
    });
  }


}
