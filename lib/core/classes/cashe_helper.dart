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
  static const String productCartItemsKey = 'product_cart_items_v1';

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

  // ------------------- سلة المنتجات (ProductCartItem) -------------------

  static List<ProductCartItem> getProductCartItems() {
    try {
      if (!cartBox.containsKey(productCartItemsKey)) return [];
      final List<dynamic> raw = cartBox.get(productCartItemsKey) ?? [];
      return raw
          .map((e) => ProductCartItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      cartBox.delete(productCartItemsKey);
      return [];
    }
  }

  static Future<void> _saveProductCart(List<ProductCartItem> items) async {
    final data = items.map((e) => e.toJson()).toList();
    await cartBox.put(productCartItemsKey, data);
  }

  static Future<void> addProductToCart(ProductCartItem item) async {
    final items = getProductCartItems();
    final i = items.indexWhere((e) => e.id == item.id);
    if (i == -1) {
      items.add(item);
    } else {
      items[i] = items[i].copyWith(quantity: items[i].quantity + item.quantity);
    }
    await _saveProductCart(items);
  }

  static Future<void> removeProductFromCart(int id) async {
    final items = getProductCartItems();
    items.removeWhere((e) => e.id == id);
    await _saveProductCart(items);
  }

  static Future<void> updateProductQuantity(int id, int newQty) async {
    final items = getProductCartItems();
    final i = items.indexWhere((e) => e.id == id);
    if (i != -1) {
      if (newQty <= 0) {
        items.removeAt(i);
      } else {
        items[i] = items[i].copyWith(quantity: newQty);
      }
      await _saveProductCart(items);
    }
  }

  static Future<void> clearProductCart() async {
    await cartBox.delete(productCartItemsKey);
  }

  static int get productCartItemCount {
    final items = getProductCartItems();
    return items.fold<int>(0, (sum, e) => sum + e.quantity);
  }

  static double get productCartTotalPrice {
    final items = getProductCartItems();
    return items.fold<double>(0.0, (sum, e) => sum + (e.price * e.quantity));
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
    DateTime expiryDateTime =
        DateTime.now().add(Duration(seconds: expiresInSeconds));
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
    List<ProductModel> productModel =
        wishlistBox.values.toList().cast<ProductModel>();
    return productModel;
  }

  static List<ProductModel>? get cartItem {
    List<ProductModel> productModel =
        cartBox.values.toList().cast<ProductModel>();
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
