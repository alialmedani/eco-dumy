import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/cart/cubit/cart_cubit.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
 import 'package:eco_dumy/featuers/product/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ✅ دالة لتقسيم السلة محلياً (pagination)
Future<Result<List<ProductCartItem>>> _paginateLocalCart({
  required List<ProductCartItem> full,
  required GetListRequest req,
}) async {
  final take = (req.take ?? 10).clamp(1, 100);
  final skip = (req.skip ?? 0).clamp(0, full.length);
  final end = (skip + take) > full.length ? full.length : (skip + take);
  final slice = full.sublist(skip, end);
  return Result<List<ProductCartItem>>(data: slice);
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading || state is CartInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CartError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        final loaded = state as CartLoaded;
        final items = loaded.cartItems;

        // ✅ عدّل حساب المجموع ليستعمل item.product.price
        final total = items.fold<double>(
          0.0,
          (sum, e) => sum + (e.product.price * e.quantity),
        );

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

          body: items.isEmpty
              ? Center(
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
                )
              : PaginationList<ProductCartItem>(
                  key: ValueKey('cart-${loaded.totalItems}'),
                  withRefresh: true,
                  physics: const BouncingScrollPhysics(),
                  onCubitCreated: (_) {},
                  repositoryCallBack: (req) {
                    if (req.skip == 0) req.take = 10;
                    return _paginateLocalCart(full: items, req: req);
                  },
                  noDataWidget: const SizedBox.shrink(),
                  listBuilder: (pageList) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: pageList.length,
                      itemBuilder: (context, index) {
                        final item = pageList[index];

                        return Dismissible(
                          key: ValueKey(item.product.id),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (_) async {
                            final ok =
                                await showDialog<bool>(
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
                            return ok;
                          },
                          onDismissed: (_) async {
                            await context.read<CartCubit>().removeProduct(item);
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
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigation.push(
                                DetailsPage(product: item.product),
                              );
                            },
                            child: CartItemCard(
                              product: item,
                              showQuantityControls: true,
                              onIncrease: () => context
                                  .read<CartCubit>()
                                  .increaseQuantity(item),
                              onDecrease: () => context
                                  .read<CartCubit>()
                                  .decreaseQuantity(item),
                              trailingIcon: Icons.delete_outline,
                              trailingColor: Colors.redAccent,
                              onTrailingPressed: () async {
                                final ok =
                                    await showDialog<bool>(
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
                                  await context.read<CartCubit>().removeProduct(
                                    item,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${item.product.title} ${"removed_from_cart".tr()}',
                                      ),
                                      backgroundColor:
                                          AppColors.kPrimaryColor2a,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

          bottomNavigationBar: Container(
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
        );
      },
    );
  }
}
