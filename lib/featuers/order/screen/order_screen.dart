import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/cart/cubit/cart_cubit.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:eco_dumy/featuers/product/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/svgs/logo_svg.svg'),
            const SizedBox(width: 8),
            Text("Your_Cart".tr()),
          ],
        ),
      ),
      body: PaginationList<ProductCartItem>(
        key: const ValueKey('cart-pagination'),
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        onCubitCreated: (cubit) {
          cartCubit.cartCubit = cubit;
        },
        repositoryCallBack: (req) async {
          final allItems = CacheHelper.getCartItems();
          final take = (req.take ?? 10).clamp(1, 100);
          final skip = (req.skip ?? 0).clamp(0, allItems.length);
          final end = (skip + take) > allItems.length
              ? allItems.length
              : (skip + take);
          final pageItems = allItems.sublist(skip, end);
          return PaginatedResult<ProductCartItem>(data: pageItems);
        },
        noDataWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/empty_cart.svg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              Text("No_items_in_your_cart".tr()),
            ],
          ),
        ),
        listBuilder: (pageList) {
          final total = pageList.fold<double>(
            0.0,
            (sum, e) => sum + (e.product.price * e.quantity),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: pageList.length,
                  itemBuilder: (context, index) {
                    final item = pageList[index];

                    return Dismissible(
                      key: ValueKey(item.product.id),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (_) async {
                        final ok = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("delete".tr()),
                                content: Text(
                                  '${"are_you_sure_to_delete".tr()} "${item.product.title}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text("cancel".tr()),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: Text("confirm".tr()),
                                  ),
                                ],
                              ),
                            ) ??
                            false;
                        return ok;
                      },
                      onDismissed: (_) async {
                        await cartCubit.removeProduct(item);
                        cartCubit.cartCubit?.getList(
                          loadMore: false,
                        ); // ✅ بدل refresh
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${item.product.title} ${"removed_from_cart".tr()}',
                            ),
                            backgroundColor: AppColors.kPrimaryColor2a,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigation.push(DetailsPage(product: item.product));
                        },
                        child: CartItemCard(
                          product: item,
                          showQuantityControls: true,
                          onIncrease: () async {
                            await cartCubit.increaseQuantity(item);
                            cartCubit.cartCubit?.getList(loadMore: false);
                          },
                          onDecrease: () async {
                            await cartCubit.decreaseQuantity(item);
                            cartCubit.cartCubit?.getList(loadMore: false);
                          },
                          trailingIcon: Icons.delete_outline,
                          trailingColor: Colors.redAccent,
                          onTrailingPressed: () async {
                            final ok = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("delete".tr()),
                                    content: Text(
                                      '${"are_you_sure_to_delete".tr()} "${item.product.title}"?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: Text("cancel".tr()),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: Text("confirm".tr()),
                                      ),
                                    ],
                                  ),
                                ) ??
                                false;

                            if (ok) {
                              await cartCubit.removeProduct(item);
                              cartCubit.cartCubit?.getList(loadMore: false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${item.product.title} ${"removed_from_cart".tr()}',
                                  ),
                                  backgroundColor: AppColors.kPrimaryColor2a,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text('${"Total".tr()}: ${total.toStringAsFixed(2)}'),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        /* Go to checkout */
                      },
                      child: Text("Checkout".tr()),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
