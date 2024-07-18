import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_init/src/core/models/cart_model.dart';


part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<CartEvent, CartState> {
  AddToCartBloc() : super(const CartState([])) {
    on<CartEvent>(addedToCart);
  }

  Future<void> addedToCart(CartEvent event, Emitter<CartState> emit) async{
    if(event is AddToCartEvent){
      final updatedCart = List<CartModel>.from(state.cartLists)..add(event.productModel);
      emit(CartState(updatedCart));
    }
    else if(event is RemoveFromCartEvent){
      final updatedCart = List<CartModel>.from(state.cartLists)..remove(event.productModel);
      emit(CartState(updatedCart));
    }
  }

}
