import 'dart:ui';

import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
class CustomOverlayColor extends WidgetStateColor {
  final Color normalColor;
  final Color pressedColor;

  CustomOverlayColor(this.normalColor, this.pressedColor)
    : super(normalColor.value);

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return pressedColor;
    }
    return normalColor;
  }
}
class CustomAlertDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required Widget body,
    String? cancelText,
    String? confirmText,
    IconData? cancelIcon,
    IconData? confirmIcon,
    bool showCancelButton = true,
  }) {
    // final isDark = HelperFunctions.isDarkMode(context);

    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Alert',
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation1, animation2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: FadeTransition(
            opacity: anim1,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: anim1, curve: Curves.elasticOut),
              ),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                // backgroundColor: isDark
                //     ? ColorsManager.darkBlue
                //     : ColorsManager.white,
                backgroundColor: AppColors.darkBluea,
                elevation: 20,
                // shadowColor: isDark
                //     ? Colors.black.withOpacity(0.7)
                //     : Colors.grey.shade400,
                shadowColor: AppColors.black.withValues(alpha: 0.7),
                titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 50,
                ),
                actionsPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                title: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.kPrimaryColor2a,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          // color: isDark
                          //     ? ColorsManager.textDark
                          //     : ColorsManager.textPrimary,
                          color: AppColors.textDarka,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                content: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 320),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 16,
                        // color: isDark
                        //     ? ColorsManager.textDark.withOpacity(0.85)
                        //     : ColorsManager.textPrimary.withOpacity(0.85),
                        color: AppColors.textDarka.withValues(alpha: 0.85),
                        height: 1.4,
                      ),
                      child: body,
                    ),
                  ),
                ),
                actions: [
                  if (showCancelButton)
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        // foregroundColor: ColorsManager.kPrimaryColor2,
                        foregroundColor: AppColors.kPrimaryColor2a,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        overlayColor: CustomOverlayColor(
                          Colors.transparent,
                          AppColors.kPrimaryColor2a.withOpacity(0.2),
                        ),
                      ),
                      icon: cancelIcon != null
                          ? Icon(cancelIcon, size: 20)
                          : const SizedBox.shrink(),
                      label: Text(cancelText ?? 'Cancel'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor2a,
                      elevation: 8,
                      shadowColor: AppColors.kPrimaryColor2a.withOpacity(
                        0.7,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overlayColor: CustomOverlayColor(
                        Colors.transparent,
                        AppColors.kPrimaryColor2a.withOpacity(0.4),
                      ),
                    ),
                    icon: confirmIcon != null
                        ? Icon(confirmIcon, size: 20)
                        : const SizedBox.shrink(),
                    label: Text(confirmText ?? 'Confirm'),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
