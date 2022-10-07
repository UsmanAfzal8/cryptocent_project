
class CartModel{
  String id;
  String productName;
  String productDescription;
  String productImage;
  String productReview;
  String productPrice;
  int itemCount = 1;

  CartModel(this.id,this.productName,this.productDescription,this.productImage,this.productReview,this.productPrice);
}