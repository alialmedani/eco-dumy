import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/home/cubit/home_cubit.dart';
import 'package:eco_dumy/featuers/home/cubit/home_state.dart';
import 'package:eco_dumy/featuers/home/screen/widget/circular_container.dart';
import 'package:eco_dumy/featuers/home/screen/widget/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sliderImages = [
      'assets/images/shoes1.jpg',
      'assets/images/shoes2.jpg',
      'assets/images/shoes3.jpg',
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              context.read<HomeCubit>().changeCarouselIndex(index);
            },
          ),
          items: sliderImages
              .map((img) => RoundedImage(imageUrl: img))
              .toList(),
        ),

        const SizedBox(height: 12),

        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (_, s) => s is SliderIndexTick,
          builder: (context, _) {
            final idx = context.read<HomeCubit>().carouselIndex;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(sliderImages.length, (i) {
                final isActive = i == idx;
                return CircularContainer(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 10),
                  backgroungColor: isActive
                      ? AppColors.kPrimaryColor2a
                      : AppColors.graya,
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
