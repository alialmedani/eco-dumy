import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomState extends Equatable {
  final double rotationDegrees;
  final double scale;

  const ImageZoomState({this.rotationDegrees = 0, this.scale = 1});

  ImageZoomState copyWith({double? rotationDegrees, double? scale}) {
    return ImageZoomState(
      rotationDegrees: rotationDegrees ?? this.rotationDegrees,
      scale: scale ?? this.scale,
    );
  }

  @override
  List<Object?> get props => [rotationDegrees, scale];
}

class ImageZoomCubit extends Cubit<ImageZoomState> {
  final PhotoViewController photoViewController;

  ImageZoomCubit(this.photoViewController) : super(const ImageZoomState());

  void rotateRight() {
    emit(state.copyWith(rotationDegrees: state.rotationDegrees + 90));
  }

  void rotateLeft() {
    emit(state.copyWith(rotationDegrees: state.rotationDegrees - 90));
  }

  void reset() {
    photoViewController.scale = photoViewController.initial.scale;
    photoViewController.position = Offset.zero;
    emit(const ImageZoomState(rotationDegrees: 0, scale: 1));
  }

  // يمكن تضيف تحكم آخر إذا بدك مثل تكبير وتصغير
}
