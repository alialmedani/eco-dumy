import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/core/constant/text_styles/font_size.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_cubit.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';
import 'package:eco_dumy/featuers/order/data/model/product_to_cart_ext.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// تقسيم محلي لقائمة المفضّلة (مثل السلة)
Future<Result<List<ProductModel>>> _paginateLocalFav({
  required List<ProductModel> full,
  required GetListRequest req,
}) async {
  final take = (req.take ?? 10).clamp(1, 100);
  final skip = (req.skip ?? 0).clamp(0, full.length);
  final end = (skip + take) > full.length ? full.length : (skip + take);
  final slice = full.sublist(skip, end);
  return Result<List<ProductModel>>(data: slice);
}

class FavoritesScreen1 extends StatefulWidget {
  const FavoritesScreen1({super.key});

  @override
  State<FavoritesScreen1> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen1> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().loadFavorite(); // أول ما تفتح الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginationList<ProductModel>(
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        noDataWidget: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPaddingSize.padding_80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_cafe_outlined,
                size: AppFontSize.size_42,
                color: AppColors.xsecondaryColor.withValues(alpha: 0.7),
              ),
              const SizedBox(height: AppFontSize.size_12),
              Text(
                'home_no_coffee'.tr(),
                style: TextStyle(
                  color: AppColors.xsecondaryColor,
                  fontSize: AppFontSize.size_16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        onCubitCreated: (cubit) {
          context.read<FavoriteCubit>().favouritetCubit = cubit;
        },
        repositoryCallBack: (data) {
          if (data.skip == 0) {
            data.take = 4;
          }

         },
        listBuilder: (apiList) {
          return SingleChildScrollView();
        },
      ),
    );
  }
}
