import '../../models/models.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterChangePageState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  ShopLoginModel loginModel;
  RegisterSuccessState({required this.loginModel});
}
class RegisterErrorState extends RegisterStates{
  String error;
  RegisterErrorState({required this.error});
}
class RegisterLoadingState extends RegisterStates{}
class RegisterChangeState extends RegisterStates{}
class UploadedUserImageState extends RegisterStates{}


class StoreDriverDataSuccessState extends RegisterStates{}
class StoreDriverDataErrorState extends RegisterStates{}
class StoreDriverDataLoadingState extends RegisterStates{}



class ChangeAccountTypeState extends RegisterStates{}
class CreateUserSuccessState extends RegisterStates{}
class CreateUserErrorState extends RegisterStates{
  String error;
  CreateUserErrorState(this.error);
}



