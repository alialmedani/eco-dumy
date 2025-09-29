import 'package:eco_dumy/featuers/home/screen/home_screen.dart';
import 'package:eco_dumy/featuers/product/screen/category/all_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// استورد Cubit
import 'navigation_cubit.dart';

// استورد صفحاتك الفعلية:

// ألوانك
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';

// لو عندك ترجمة:
import 'package:easy_localization/easy_localization.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  // بدّل الشاشات حسب مشروعك
  final List<Widget> screens = [
    HomeScreen(),
    const Placeholder(),
    const Placeholder(),

    AllCategoriesScreen(),
    // حط شاشة التصنيفات تبعك هون
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          final cubit = context.read<NavigationCubit>();

          return Scaffold(
            backgroundColor: AppColors.darka, // عدّل إذا بدك
            body: IndexedStack(index: state.selectedIndex, children: screens),
            bottomNavigationBar: Container(
              color: AppColors.darka,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: state.selectedIndex == 0
                        ? Icons.home
                        : Icons.home_outlined,
                    label: "home".tr(),
                    state: state,
                    cubit: cubit,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: state.selectedIndex == 1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_checkout_rounded,
                    label: "Order".tr(),
                    state: state,
                    cubit: cubit,
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: state.selectedIndex == 2
                        ? Icons.favorite
                        : Icons.favorite_border,
                    label: "favourite".tr(),
                    state: state,
                    cubit: cubit,
                  ),
                  _buildNavItem(
                    index: 3,
                    icon: state.selectedIndex == 3
                        ? Icons.category
                        : Icons.category_outlined,
                    label: "categories".tr(),
                    state: state,
                    cubit: cubit,
                  ),
                  _buildNavItem(
                    index: 4,
                    icon: state.selectedIndex == 4
                        ? Icons.person
                        : Icons.person_outline,
                    label: "Profile".tr(),
                    state: state,
                    cubit: cubit,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required NavigationState state,
    required NavigationCubit cubit,
  }) {
    final isSelected = state.selectedIndex == index;

    return GestureDetector(
      onTap: () => cubit.onIconTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.mainBluea.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: isSelected ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Icon(
                    icon,
                    color: isSelected ? AppColors.mainBluea : AppColors.graya,
                  ),
                );
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? Text(
                      label,
                      key: ValueKey(label),
                      style: const TextStyle(
                        color: AppColors.mainBluea,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox.shrink(),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ],
        ),
      ),
    );
  }
}
