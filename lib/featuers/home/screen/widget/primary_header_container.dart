 
import 'package:eco_dumy/featuers/home/screen/widget/circular_container.dart';
import 'package:eco_dumy/featuers/home/screen/widget/curvet_edget_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return CurvetEdgetWidget(
      child: Container(
        // color: isDark ? ColorsManager.dark : ColorsManager.mainBlue,
        child: SizedBox(
          height: 400.h,
          child: Stack(
            children: [
              Positioned(
                top: -150.h,
                right: -250,
                child: CircularContainer(
                  backgroungColor: Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  backgroungColor: Colors.white.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
