part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
class CategoryThumbsUpdated extends ProductState {
  final Map<String, String?> thumbs; // slug -> imageUrl (قد تكون null)
  CategoryThumbsUpdated(this.thumbs);
}
