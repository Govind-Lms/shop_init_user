import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_init/src/core/helper/order_helper.dart';

import '../../../models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrder>(loadOrder);
    on<AddOrder>(addOrder);
  }

  final service = OrderService();
   Future<void> loadOrder(LoadOrder event, state) async {
    try {
      emit(OrderLoading());
      service.getOrderList().listen((orders){
        emit(OrderSuccess(orderList: orders));
      });
    } catch (e) {
      emit(const OrderError('Failed to load Order info data'));
    }
  }

  Future<void> addOrder(AddOrder event, state) async {
    try {
      emit(OrderLoading());
      await service.addOrderList(event.orderModel);
    } catch (e) {
      emit(const OrderError("Error in adding Order info"));
    }
  }


}
