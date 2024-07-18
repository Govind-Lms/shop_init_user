part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  final List<OrderModel>? orderList;
  const OrderState({this.orderList});
  
  @override
  List<Object?> get props => [orderList];
}


final class OrderInitial extends OrderState {
  OrderInitial(): super(orderList: []);
  @override
  List<Object?> get props => [];
}

final class OrderLoading extends OrderState {
  OrderLoading(): super(orderList: []);
  @override
  List<Object?> get props => [];
}

final class OrderSuccess extends OrderState {
  final List<OrderModel> orderList;

  const OrderSuccess({required this.orderList});
  @override
  List<Object?> get props => [orderList];
}

final class OrderError extends OrderState {
  final String errorMessage;
  const OrderError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
