// root_state.dart
part of 'root_cubit.dart';

abstract class RootState {}

class RootInitial extends RootState {}

class ChangeIndexState extends RootState {
  final int currentIndex;
  ChangeIndexState(this.currentIndex);
}

class ToggleSubmenuState extends RootState {
  final bool show;
  ToggleSubmenuState(this.show);
}
