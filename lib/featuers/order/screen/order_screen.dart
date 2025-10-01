import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/order/cubit/order_cubit.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// تقسيم محلي للسلة حسب skip/take
Future<Result<List<ProductCartItem>>> _paginateLocalCart({
  required List<ProductCartItem> full,
  required GetListRequest req,
}) async {
  final take = (req.take ?? 10).clamp(1, 100);
  final skip = (req.skip ?? 0).clamp(0, full.length);
  final end = (skip + take) > full.length ? full.length : (skip + take);
  final slice = full.sublist(skip, end);
  return Result<List<ProductCartItem>>(
    data: slice,
  ); // ما في success بواجهة Result تبعك
}

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (p, c) => c is OrderChanged || p is OrderInitial,
      builder: (context, state) {
        final cubit = context.read<OrderCubit>();
        final cart = cubit.cart;
        final total = cubit.totalPrice;

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

          body: cart.isEmpty
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
                  withRefresh: true,
                  physics: const BouncingScrollPhysics(),
                  onCubitCreated: (_) {},
                  repositoryCallBack: (req) {
                    if (req.skip == 0) req.take = 10;
                    // مهم: استعمل snapshot الحالي من السلة (رح يُعاد بناء الـWidget عند أي تغيير)
                    return _paginateLocalCart(full: cubit.cart, req: req);
                  },
                  noDataWidget: const SizedBox.shrink(),
                  listBuilder: (pageList) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: pageList.length,
                      itemBuilder: (context, index) {
                        final item = pageList[index];

                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 350 + index * 100),
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 25 * (1 - value)),
                              child: child,
                            ),
                          ),
                          child: Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (_) async {
                              // استخدم حوار التأكيد الخاص فيك إن موجود
                              // أو رجّع true مباشرة إذا ما بدك حوار
                              return await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("delete".tr()),
                                      content: Text(
                                        '${"are_you_sure_to_delete".tr()} "${item.title}"?',
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
                            },
                            onDismissed: (_) async {
                              await cubit.removeProduct(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${item.title} ${"removed_from_cart".tr()}',
                                  ),
                                  backgroundColor: AppColors.kPrimaryColor2a,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            background: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: CartItemCard(
                              product: item,
                              onIncrease: () => cubit.increaseQuantity(item),
                              onDecrease: () => cubit.decreaseQuantity(item),
                              onRemove: () async {
                                final ok =
                                    await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text("delete".tr()),
                                        content: Text(
                                          '${"are_you_sure_to_delete".tr()} "${item.title}"?',
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
                                  await cubit.removeProduct(item);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

          // زر الدفع / الملخص
          // bottomNavigationBar: CheckOut(totalPrice: total),
        );
      },
    );
  }
}
