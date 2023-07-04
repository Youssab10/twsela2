

import '../../models/models.dart';

abstract class LoginStates{}
 class LoginInitialState extends LoginStates{}

 class LoginChangeState extends LoginStates{}
 class LoginLoadingState extends LoginStates{}
 class LoginSuccessState extends LoginStates{}
 class LoginErrorState extends LoginStates{
 String error;
 LoginErrorState(this.error);
 }