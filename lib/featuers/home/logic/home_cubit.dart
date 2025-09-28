// import 'dart:async';

//    import 'package:eco_dumy/featuers/home/data/repos/home_repo.dart';
// import 'package:eco_dumy/featuers/home/logic/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class HomeCubit extends Cubit<HomeState> {
//   final HomeRepo _homeRepo;
//   final TextEditingController searchController = TextEditingController();

//   int currentSkip = 0;
//   final int limit = 5;
//   Timer? _debounce;

//   HomeCubit(this._homeRepo) : super(const HomeState()) {
//     searchController.addListener(_onSearchChanged);
//   }

//   void _onSearchChanged() {
//     final query = searchController.text.trim();
//     debounce(() => searchProducts(query));
//   }

//   void debounce(VoidCallback action, [Duration duration = const Duration(milliseconds: 500)]) {
//     _debounce?.cancel();
//     _debounce = Timer(duration, action);
//   }

//   void updateSliderIndex(int index) {
//     emit(state.copyWith(sliderIndex: index));
//   }

//    void loadHomeData(List<CategoryModel> categories) async {
//   if (isClosed) return;
//   currentSkip = 0;
//   if (isClosed) return;
//   emit(state.copyWith(isLoadingSpecializations: true));

//   final result = await _homeRepo.getProdcut(limit: limit, skip: currentSkip);
//   if (isClosed) return;

//   result.when(
//     success: (response) {
//       if (isClosed) return;
//       emit(state.copyWith(
//         products: response.products ?? [],
//         isLoadingSpecializations: false,
//       ));
//       getCategoriesWithFirstProduct(categories);
//     },
//     failure: (errorHandler) {
//       if (isClosed) return;
//       emit(state.copyWith(
//         error: errorHandler,
//         isLoadingSpecializations: false,
//       ));
//     },
//   );
// }

//   void loadMoreProducts() async {
//     if (state.isLoadingMore) return;

//     emit(state.copyWith(isLoadingMore: true));
//     currentSkip += limit;

//     final result = await _homeRepo.getProdcut(limit: limit, skip: currentSkip);
//     result.when(
//       success: (response) {
//         final updatedList = [...state.products, ...?response.products];
//         emit(state.copyWith(products: updatedList, isLoadingMore: false));
//       },
//       failure: (_) {
//         emit(state.copyWith(isLoadingMore: false));
//       },
//     );
//   }

//   void getCategoriesWithFirstProduct(List<CategoryModel> categories) async {
//     if (isClosed) return;

//     emit(state.copyWith(isLoadingCategories: true));

//     final futures = categories.map((category) async {
//       final result = await _homeRepo.getFirstProductByCategory(category.slug);
//       return result.whenOrNull(success: (product) => product == null ? null : MapEntry(category.name, product));
//     });

//     final results = await Future.wait(futures);
//     final map = Map.fromEntries(results.whereType<MapEntry<String, Product>>());

//     if (isClosed) return;

//     emit(state.copyWith(
//       categoriesWithProduct: map,
//       isLoadingCategories: false,
//     ));
//   }

//   void searchProducts(String query) async {
//     emit(state.copyWith(isSearching: true, query: query));

//     if (query.isEmpty) {
//       emit(state.copyWith(isSearching: false, searchResults: [], query: ''));
//       return;
//     }

//     final result = await _homeRepo.searchProducts(query);

//     result.when(
//       success: (products) {
//         emit(state.copyWith(isSearching: false, searchResults: products, query: query));
//       },
//       failure: (_) {
//         emit(state.copyWith(isSearching: false, searchResults: [], query: query));
//       },
//     );
//   }

//   void updateScrollPosition(double position) {
//     emit(state.copyWith(scrollPosition: position));
//   }

//   void fetchProductsByCategory(String categorySlug) async {
//     emit(state.copyWith(isLoadingSpecializations: true, error: null));

//     final result = await _homeRepo.getProductsByCategory(categorySlug);
//     result.when(
//       success: (response) {
//         emit(state.copyWith(
//           products: response.products ?? [],
//           isLoadingSpecializations: false,
//           error: null,
//         ));
//       },
//       failure: (errorHandler) {
//         emit(state.copyWith(
//           isLoadingSpecializations: false,
//           error: errorHandler,
//         ));
//       },
//     );
//   }

//   @override
//   Future<void> close() {
//     searchController.dispose();
//     _debounce?.cancel();
//     return super.close();
//   }
// }
