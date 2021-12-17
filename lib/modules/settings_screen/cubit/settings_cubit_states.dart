abstract class ShopSettingsStates {}

class ShopSettingsInitState extends ShopSettingsStates {}

class ShopSettingsChangeVisPassState extends ShopSettingsStates {}

class ShopSettingsLoadingState extends ShopSettingsStates {}

class ShopSettingsSuccessState extends ShopSettingsStates {
  bool status ;

  ShopSettingsSuccessState(this.status);
}

class ShopSettingsErrorState extends ShopSettingsStates {}

class ShopSettingsUpdateSuccessState extends ShopSettingsStates {
  bool status ;

  ShopSettingsUpdateSuccessState(this.status);
}

class ShopSettingsUpdateErrorState extends ShopSettingsStates {}