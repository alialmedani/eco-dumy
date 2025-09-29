import 'package:bloc/bloc.dart';

class NavigationState {
  final int selectedIndex;
  NavigationState({required this.selectedIndex});

  NavigationState copyWith({int? selectedIndex}) =>
      NavigationState(selectedIndex: selectedIndex ?? this.selectedIndex);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(selectedIndex: 0));

  void onIconTap(int index) => emit(state.copyWith(selectedIndex: index));
}
