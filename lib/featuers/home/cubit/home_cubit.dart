import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


int carouselIndex = 0;

  void changeCarouselIndex(int pageIndex) {
    carouselIndex = pageIndex;
    emit(SliderIndexTick()); // State بسيط
  }
}
