


abstract class AppStates {}
class AppInitialState extends AppStates{}
class ChangeDriverBottomNavBarItemState extends AppStates{}
class ChangeBottomNavBarItemState extends AppStates{}
class AppChangeProfileIndexState extends AppStates{}
class ShopSuccessState extends AppStates{}
class ShopLoadingState extends AppStates{}
class ShopErrorState extends AppStates{
  String error;
  ShopErrorState({required this.error});
}

class ShopSuccessCategoriesState extends AppStates{}
class ShopErrorCategoriesState extends AppStates{
  String error;
  ShopErrorCategoriesState({required this.error});
}
/*

class ShopSuccessFavoritesState extends ShopStates{
   ChangeFavoritesModel? model;
  ShopSuccessFavoritesState({required this.model});
}
class ShopSuccessChangeFavoritesState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates{
  String error;
  ShopErrorFavoritesState({required this.error});
}
*/

class ShopSuccessGetFavoritesState extends AppStates{}
class ShopLoadingGetFavoritesState extends AppStates{}
class ShopErrorGetFavoritesState extends AppStates{
  String error;
  ShopErrorGetFavoritesState({required this.error});
}





class ShopSuccessUpdateUserDataState extends AppStates{}
class ShopLoadingUpdateUserDataState extends AppStates{}
class ShopErrorUpdateUserDataState extends AppStates{
  String error;
  ShopErrorUpdateUserDataState({required this.error});
}



class ShopSuccessGetUserDataState extends AppStates{}
class ShopLoadingGetUserDataState extends AppStates{}
class ShopErrorGetUserDataState extends AppStates{
  String error;
  ShopErrorGetUserDataState({required this.error});
}



class AddTripSuccessState extends AppStates{}
class AddTripErrorState extends AppStates{}
class AddTripLoadingState extends AppStates{}
class AppGetAllTripsSuccessState extends AppStates{}
class AppMyTripsSuccessState extends AppStates{}
class AppGetDriverTripsSuccessState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class AppGetAllPromotionsSuccessState extends AppStates{}

class AddTripToUserSuccessState extends AppStates{}
class AddTripToUserErrorState extends AppStates{}
class CancelTripState extends AppStates{}
class UpdateUserSuccessState extends AppStates{}
class UpdateUserLoadingState extends AppStates{}
