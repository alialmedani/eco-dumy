import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/home/screen/widget/appbarr.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);
    // return FutureBuilder<String>(
    //   future: SharedPrefHelper.getString(SharedPrefKeys.firstName),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     }

    //     String firstName = snapshot.data ?? 'Guest';

    return Appbarr(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good_day_for_shopping".tr(),
            style: Theme.of(context).textTheme.labelLarge!.apply(
              // color: dark ? AppColors.darkGreya : AppColors.grey1a,
              color: AppColors.darkGreya,
            ),
          ),
          Text(
            CacheHelper.userInfo?.firstName ?? "",
            style: Theme.of(context).textTheme.headlineSmall!.apply(
              // color: dark ? AppColors.darkerGreya : AppColors.white,
              color: AppColors.darkerGreya,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // context.read<NavigationCubit>().onIconTap(1);
          },
          icon: Icon(
            Icons.shopify_rounded,
            // color: dark ? AppColors.backgroundDarka : AppColors.white,
            color: AppColors.backgroundDarka,
            size: AppPaddingSize.padding_40,
          ),
        ),
      ],
    );
  }
}

//     );
//   }
// }
