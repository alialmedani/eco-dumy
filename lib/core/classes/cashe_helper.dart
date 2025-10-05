import 'package:eco_dumy/core/constant/end_points/cashe_helper_constant.dart';
import 'package:eco_dumy/featuers/auth/data/model/login_model.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheHelper {
  // ✅ عرّف المفتاح هنا، مش داخل init()

  static late Box<dynamic> box;
  static late Box<dynamic> wishlistBox;
  static late Box<dynamic> cartBox;
  static late Box<dynamic> currentUserBox;
  static late Box<dynamic> settingBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox("default_box");
    wishlistBox = await Hive.openBox("model_box");
    cartBox = await Hive.openBox("cart_box");
    currentUserBox = await Hive.openBox("current_user_box");
    settingBox = await Hive.openBox("setting_box");
  }

  // Cart operations

  // إضافة عنصر للسلة
  static Future<void> addToCart(ProductCartItem cartItem) async {
    List<ProductCartItem> currentCart = getCartItems();

    int existingIndex = currentCart.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );

    if (existingIndex != -1) {
      currentCart[existingIndex] = currentCart[existingIndex].copyWith(
        quantity: currentCart[existingIndex].quantity + cartItem.quantity,
      );
    } else {
      currentCart.add(cartItem);
    }

    await _saveCartItems(currentCart);
  }

  // إزالة عنصر من السلة
  static Future<void> removeFromCart(ProductCartItem cartItem) async {
    List<ProductCartItem> currentCart = getCartItems();
    currentCart.removeWhere((item) => item.product.id == cartItem.product.id);
    await _saveCartItems(currentCart);
  }

  static Future<void> updateCartItemQuantity(
    ProductCartItem cartItem,
    int newQty,
  ) async {
    List<ProductCartItem> currentCart = getCartItems();
    int index = currentCart.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );

    if (index != -1) {
      if (newQty <= 0) {
        currentCart.removeAt(index);
      } else {
        currentCart[index] = currentCart[index].copyWith(quantity: newQty);
      }
      await _saveCartItems(currentCart);
    }
  }


  static List<ProductCartItem> getCartItems() {
    try {
      if (!cartBox.containsKey(cartItems)) return [];

      List<dynamic> cartData = cartBox.get(cartItems) ?? [];
      return cartData
          .map(
            (item) => ProductCartItem.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    } catch (e) {
      // If there's any error loading cart items, clear the cache and return empty list
      cartBox.delete(cartItems);
      return [];
    }
  }

  static Future<void> clearCart() async {
    await cartBox.delete(cartItems);
  }
//favourite
// مفتاح ثابت للمفضّلة
  static const String favoriteIdsKey = 'favorite_ids_v1';

  // جلب Set<int> من المفضّلة
  static Future<Set<int>> getFavoriteIds() async {
    // تأكد إن الصناديق مفتوحة (init() لازم يكون منادي عليه بالـ main)
    final List<dynamic> raw =
        box.get(favoriteIdsKey, defaultValue: <dynamic>[]) as List<dynamic>;
    return raw.map((e) => (e as num).toInt()).toSet();
  }

  // حفظ Set<int> بالمفضّلة
  static Future<void> saveFavoriteIds(Set<int> ids) async {
    await box.put(favoriteIdsKey, ids.toList());
  }

// في CacheHelper
  static Future<void> toggleFavorite(ProductModel p) async {
    // خزّن/اقرأ كماب بدل object لو ما عندك Hive adapters
    final list = getFavorites();
    final i = list.indexWhere((e) => e.id == p.id);
    if (i == -1) {
      list.add(p);
    } else {
      list.removeAt(i);
    }
    await _saveFavorites(list);
  }

  static List<ProductModel> getFavorites() {
    if (!wishlistBox.containsKey('favorites')) return [];
    final raw = (wishlistBox.get('favorites') as List?) ?? [];
    return raw
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> _saveFavorites(List<ProductModel> items) async {
    await wishlistBox.put('favorites', items.map((e) => e.toJson()).toList());
  }

  // Debug method to test cart operations
  static Future<void> debugClearCartAndTest() async {
    try {
      await clearCart();
    } catch (e) {
      debugPrint("Error clearing cart: $e");
    }
  }

  static int get cartItemCount {
    List<ProductCartItem> cart = getCartItems();
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  static Future<void> _saveCartItems(List<ProductCartItem> cartItemsList) async {
    List<Map<String, dynamic>> cartData = cartItemsList
        .map((item) => item.toJson())
        .toList();
    await cartBox.put(cartItems, cartData);
  }
  // ------------------- بقية دوالك كما هي -------------------
  // static Future<void> setCurrentUserInfo(CurrentUserModel? value) async {
  //   if (value != null) {
  //     await currentUserBox.put('user_info', value);
  //   } else {
  //     if (kDebugMode) {
  //       print("Attempted to save null user info to cache");
  //     }
  //   }
  // }

  // static Future<void> setSetting(SettingModel? value) async {
  //   if (value != null) {
  //     await settingBox.put('setting', value);
  //   } else {
  //     if (kDebugMode) {
  //       print("Attempted to save null setting to cache");
  //     }
  //   }
  // }

  static Future<void> setLang(String value) => box.put(languageValue, value);

  // static Future<void> toggleWishList(ProductModel value) async {
  //   if (!Hive.isBoxOpen('model_box')) {
  //     wishlistBox = await Hive.openBox('model_box');
  //   }

  //   final List<ProductModel> currentWishList =
  //       wishlistBox.values.toList().cast<ProductModel>();
  //   final existingIndex =
  //       currentWishList.indexWhere((item) => item.id == value.id);

  //   if (existingIndex >= 0) {
  //     currentWishList.removeAt(existingIndex);
  //   } else {
  //     currentWishList.add(value);
  //   }

  //   await wishlistBox.clear();
  //   await wishlistBox.addAll(currentWishList);
  // }

  // static Future<void> addToCart(
  //     ProductModel value, bool operation, BuildContext context) async {
  //   if (!Hive.isBoxOpen('cart_box')) {
  //     cartBox = await Hive.openBox('cart_box');
  //   }

  //   final List<ProductModel> currentCart =
  //       cartBox.values.toList().cast<ProductModel>();
  //   final existingIndex = currentCart.indexWhere((item) => item.id == value.id);

  //   if (existingIndex >= 0) {
  //     if (operation) {
  //       currentCart[existingIndex].quantity += 1;
  //     } else {
  //       currentCart[existingIndex].quantity -= 1;

  //       if (currentCart[existingIndex].quantity == 0) {
  //         currentCart.removeAt(existingIndex);
  //       }
  //     }
  //   } else {
  //     currentCart.add(value);
  //   }

  //   await cartBox.clear();
  //   if (currentCart.isNotEmpty) {
  //     await cartBox.addAll(currentCart);
  //   }

  //   if (context.mounted) {
  //     context.read<CartCubit>().getCartItem();
  //   }
  // }

  static Future<void> setToken(String? value) =>
      box.put(accessToken, value ?? '');
  static Future<void> setDeviceToken(String? value) =>
      box.put(deviceToken, value ?? '');
  static Future<void> setRefreshToken(String? value) =>
      box.put(refreshToken, value ?? '');
  static Future<void> setUserId(String? value) => box.put(userId, value ?? 0);
  static Future<void> setExpiresIn(int? value) =>
      box.put(expiresIn, value ?? 0);

  static Future<void> setFirstTime(bool value) async {
    await box.put(isFirstTime, value);
  }

  static Future<void> setDateWithExpiry(int expiresInSeconds) {
    DateTime expiryDateTime = DateTime.now().add(
      Duration(seconds: expiresInSeconds),
    );
    return box.put(date, expiryDateTime);
  }

  ////////////////////////////////Get///////////////////////////////

  // static CurrentUserModel? get currentUserInfo {
  //   if (!currentUserBox.containsKey('user_info')) return null;
  //   return currentUserBox.get('user_info');
  // }

  // static SettingModel? get setting {
  //   if (!settingBox.containsKey('setting')) return null;
  //   return settingBox.get('setting');
  // }

  static String get lang => box.get(languageValue) ?? 'en';
  static String? get token {
    if (!box.containsKey(accessToken)) return null;
    return "${box.get(accessToken)}";
  }

  static String? get getDeviceToken {
    if (!box.containsKey(deviceToken)) return null;
    return "${box.get(deviceToken)}";
  }

  static String? get refreshtoken {
    if (!box.containsKey(refreshToken)) return null;
    return "${box.get(refreshToken)}";
  }

  static List<ProductModel>? get wishlist {
    List<ProductModel> productModel = wishlistBox.values
        .toList()
        .cast<ProductModel>();
    return productModel;
  }

  static List<ProductModel>? get cartItem {
    List<ProductModel> productModel = cartBox.values
        .toList()
        .cast<ProductModel>();
    return productModel;
  }

  static String? get userID {
    if (!box.containsKey(userId)) return null;
    return "${box.get(userId)}";
  }

  static bool get firstTime => box.get(isFirstTime) ?? true;
  static int? get expiresin => box.get(expiresIn);
  static DateTime? get datenow => box.get(date);

  // set
  static Future<void> setUserInfo(LoginModel? value) async {
    if (value == null) return;
    await box.put(userModel, value.toJson()); // <-- خزّنه كـ Map
  }

  // get
  static LoginModel? get userInfo {
    if (!box.containsKey(userModel)) return null;
    final data = box.get(userModel);
    if (data is Map) {
      return LoginModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static void deleteCertificates() {
    setToken(null);
    setUserId(null);
  }
}
