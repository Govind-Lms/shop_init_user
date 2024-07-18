part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object> get props => [];
}

final class LoadOrder extends OrderEvent{
  @override
  List<Object> get props => [];
}

final class AddOrder extends OrderEvent{
  final OrderModel orderModel;
  const AddOrder(this.orderModel);
  @override
  List<Object> get props => [orderModel];
}

final class UpdateOrder extends OrderEvent{
  final OrderModel orderModel;
  const UpdateOrder(this.orderModel);
  @override
  List<Object> get props => [orderModel];
}

final class DeleteOrder extends OrderEvent{
  final OrderModel orderModel;
  const DeleteOrder(this.orderModel);
  @override
  List<Object> get props => [orderModel];
}


