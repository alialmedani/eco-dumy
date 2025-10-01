part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

/// نبضة لتريغر الـ rebuild
final class OrderChanged extends OrderState {
  final int version;
  OrderChanged(this.version);
}
