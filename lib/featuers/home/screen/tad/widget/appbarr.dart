  import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:flutter/material.dart';

class Appbarr extends StatelessWidget   {
  const Appbarr({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddingSize.padding_16,
        vertical: AppPaddingSize.padding_16,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_right),
              )
            : leadingIcon != null
            ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  }
