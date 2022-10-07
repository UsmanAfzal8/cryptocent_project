import 'ad_to_cart_model.dart';

List<CartModel> cartItems = [];

cartContains(String id){
  for(int i = 0; i < cartItems.length; i++){
    if(cartItems[i].id == id)
      return true;
  }
  return false;
}