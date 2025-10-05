import 'package:eco_dumy/core/classes/cashe_helper.dart';

// const baseUrl = 'https://api.ecommerce.jedar.demo.erpmawared.com/'; //
const baseUrl = 'https://dummyjson.com/'; //base_url_live
// const baseUrl = 'https://api.ecommerce.demo.jedar-center.com/'; //base_url_demo
// var baseImageUrl = "${CacheHelper.setting?.baseImageUrl}/"; //base_Image_url

/////auth_url////////////
const loginUrl = '${baseUrl}auth/login';
const registerUrl = '${baseUrl}api/app/mobile-ecommerce-user-info';
const String getProductsBaseUrl = 'https://dummyjson.com/products';
// فالـ url يصير .../products/category/{slug}

const getAllProduct = '${baseUrl}products';
const getCategoriesUrl = '${baseUrl}products/categories';
String productsByCategoryUrl(String slug) => '$baseUrl/products/category/$slug';
const String getProfile = "${baseUrl}auth/me";

// منتجات التصنيف المحدد

//
// const String createDrinkOrderUrl = '${baseUrl}api/app/order';
// const String changeDrinkOrderStatusUrl =
//     '${baseUrl}api/app/Order/change-status';
// const String getOrdersUrl = '${baseUrl}api/app/order';
// const String getCurrentUserOrdersUrl = '${baseUrl}api/app/Order/current_user';
// const String createDrinkOrderLiteUrl = "$baseUrl/api/app/order";
/////auth_url////////////
///

///user url////////////

const currentUserUrl = '${baseUrl}api/app/current-customer';
// const getPlaceUrl = '${baseUrl}api/app/floor/offices/autocomplete';

//order//

///// home page

const sliderBannerUrl = '${baseUrl}api/app/mobile-slider-banner';
const brandUrl = '${baseUrl}api/app/mobile-brand';
const brandByCategoryUrl = '${baseUrl}api/app/mobile-brand/by-category';
const mostSoldMatrixUrl = '${baseUrl}api/app/mobile-matrix/top-list';
const offerMatrixUrl = '${baseUrl}api/app/mobile-matrix/by-discount';
const allMatrixUrl = '${baseUrl}api/app/mobile-matrix';
const matrixByCategoryUrl = '${baseUrl}api/app/mobile-matrix/by-category';
const matrixByBrandUrl = '${baseUrl}api/app/mobile-matrix/by-brand';
const allCategoryUrl = '${baseUrl}api/app/mobile-category/top';
const allCategoryForSearchUrl = '${baseUrl}api/app/mobile-category';
const categoryAndFamilyUrl = '${baseUrl}api/app/mobile-category/treelist';
const productByMatrixUrl = '${baseUrl}api/app/mobile-product/by-matrix';
const oneProductUrl = '${baseUrl}api/app/mobile-product';
const createOrderUrl = '${baseUrl}api/app/mobile-ecommerce-order';
const promoCodeUrl =
    '${baseUrl}api/app/mobile-ecommerce-order/check-promo-code';
const configUrl = '${baseUrl}api/app/mobile-configuration/config';
const setDeviceIdUrl =
    '${baseUrl}api/app/mobile-ecommerce-user-info/set-device';
const currentOrdersUrl =
    '${baseUrl}api/app/mobile-ecommerce-order/current-list';
const previousOrdersUrl =
    '${baseUrl}api/app/mobile-ecommerce-order/previous-list';
const enumOrderStatusUrl = '${baseUrl}api/app/ecommerce-order-status';
const oneOrderUrl = '${baseUrl}api/app/mobile-ecommerce-order';
const searchUrl = '${baseUrl}api/app/mobile-matrix/by-filter';
const autoCompleteUrl = '${baseUrl}api/app/mobile-dashboard/autocomplete';
const notificationUrl = '${baseUrl}api/app/mobile-ecommerce-notification';
const sendOTPUrl = '${baseUrl}api/app/mobile-otp/send-verification-code';
const checkOTPUrl = '${baseUrl}api/app/mobile-otp/check-verification';
const resetPasswordUrl = '${baseUrl}api/app/mobile-user/set-password';
const forgotPasswordUrl = '${baseUrl}api/app/mobile-user/forgot-password';
const areaUrl = '${baseUrl}api/app/mobile-area/by-filter';
const governorateUrl = '${baseUrl}api/app/mobile-area/governorate-by-filter';
