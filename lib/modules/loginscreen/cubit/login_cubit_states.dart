abstract class ShopLoginStates {}

class ShopLoginInitState extends ShopLoginStates {}

class ShopLoginChangeVisPassState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  bool status ;

  ShopLoginSuccessState(this.status);
}

class ShopLoginErrorState extends ShopLoginStates {}
