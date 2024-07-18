part of 'add_to_cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}


final class AddToCartEvent extends CartEvent{
  final CartModel productModel;
  const AddToCartEvent( {required this.productModel});
  @override
  List<Object> get props => [productModel];
}



final class RemoveFromCartEvent extends CartEvent{
  final CartModel productModel;
  const RemoveFromCartEvent({required this.productModel});
  @override
  List<Object> get props => [productModel];
}