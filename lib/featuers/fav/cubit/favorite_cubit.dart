// favorite_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  PaginationCubit? favouritetCubit;



  void loadFavorite() {
    try {
      emit(FavoriteLoading());
      final cartItems = CacheHelper.getCartItems();
      final totalItems = CacheHelper.cartItemCount;
      emit(FavoriteLoaded(cartItems: cartItems, totalItems: totalItems));
    } catch (e) {
      emit(FavoriteError('Failed to load cart: ${e.toString()}'));
    }
  }

  
 

  Future<void> addToFav(ProductCartItem cartItem) async {
    try {
      await CacheHelper.addToCart(cartItem);
      loadFavorite(); // Reload cart to update UI
    } catch (e) {
      emit(FavoriteError('Failed to add item to cart: ${e.toString()}'));
    }
  }

  // Future<void> removeFromFavorite(
  //   int productId,
  //   String productTitle,
  //   String productThumbnail,
  //   double prodcutPrice,
  // ) async {
  //   try {
  //     await CacheHelper.removeFromCart(   
 
       
  //       productThumbnail,
  //       prodcutPrice,
    
  //   );
  //     loadFavorite(); // Reload cart to update UI
  //   } catch (e) {
  //     emit(FavoriteError('Failed to remove item from cart: ${e.toString()}'));
  //   }
  // }

  

  Future<void> clearCart() async {
    try {
      await CacheHelper.clearCart();
      loadFavorite(); // Reload cart to update UI
    } catch (e) {
      emit(FavoriteError('Failed to clear cart: ${e.toString()}'));
    }
  }
  }











  // محوّل آمن من dynamic -> ProductModel
//   ProductModel _ensureProduct(dynamic x) {
//     if (x is ProductModel) return x;
//     if (x is Map) {
//       return ProductModel.fromJson(Map<String, dynamic>.from(x));
//     }
//     throw ArgumentError('Invalid favorite item type: ${x.runtimeType}');
//   }

//   // استخراج معرّف كنقطة مقارنة موحّدة (int)
//   int _extractId(ProductModel p) {
//     // لو كان p.id أصلاً int تمام؛ لو كان String، حوّله إلى int إن أمكن.
//     final id = p.id;
//     return id;
//   }

//   Future<void> load() async {
//     try {
//       emit(FavoriteLoading());

//       // قد يرجع Maps من الكاش؛ حوّلهم لمنتجات
//       final raw =
//           CacheHelper.getFavorites(); // List<dynamic> أو List<ProductModel>
//       final list = raw.map(_ensureProduct).toList();

//       // ids مشتقة من المنتجات نفسها لضمان التطابق
//       final ids = list.map(_extractId).toSet();

//       emit(FavoriteLoaded(items: list, ids: ids));
//     } catch (e) {
//       emit(FavoriteError('Failed to load favorites: $e'));
//     }
//   }

//   Future<void> toggle(ProductModel product) async {
//     try {
//       final prev = state;

//       if (prev is FavoriteLoaded) {
//         final current = List<ProductModel>.from(prev.items);
//         final pid = _extractId(product);
//         final idx = current.indexWhere((p) => _extractId(p) == pid);

//         if (idx >= 0) {
//           current.removeAt(idx);
//         } else {
//           current.add(product);
//         }

//         // emit فوري (Optimistic)
//         final idsNow = current.map(_extractId).toSet();
//         emit(FavoriteLoaded(items: current, ids: idsNow));

//         // خزّن بالكاش، ثم (اختياري) أعد المزامنة
//         await CacheHelper.toggleFavorite(product);

//         final syncedRaw = CacheHelper.getFavorites();
//         final synced = syncedRaw.map(_ensureProduct).toList();
//         emit(
//           FavoriteLoaded(items: synced, ids: synced.map(_extractId).toSet()),
//         );
//       } else {
//         // أول مرة
//         await CacheHelper.toggleFavorite(product);
//         final raw = CacheHelper.getFavorites();
//         final list = raw.map(_ensureProduct).toList();
//         emit(FavoriteLoaded(items: list, ids: list.map(_extractId).toSet()));
//       }
//     } catch (e) {
//       emit(FavoriteError('Failed to toggle favorite: $e'));
//     }
//   }

//   bool isFav(int productId) {
//     final s = state;
//     if (s is FavoriteLoaded) {
//       // دعم للحالات التي يصل فيها productId كسلسلة
//       final canonical = productId;
//       if (s.ids.contains(canonical)) return true;
//       return s.items.any((p) => _extractId(p) == canonical);
//     }
//     return false;
//   }
// }
