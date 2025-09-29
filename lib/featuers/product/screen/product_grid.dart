// lib/featuers/home/new/screen/tad/widget/product_grid.dart
import 'package:eco_dumy/featuers/product/screen/product_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
 
class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,

        shrinkWrap: true, 
         itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 320,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) =>
            ProductListViewItem(product: products[index], itemIndex: index),
      ),
    );
  }
}
