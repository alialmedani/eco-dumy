import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductModel> items;

  const FavoriteLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
