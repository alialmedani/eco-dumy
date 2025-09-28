  import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/image_zoom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

class ImageZoomPage extends StatelessWidget {
  final String imageUrl;

  const ImageZoomPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // final backgroundColor = isDark ? ColorsManager.dark : ColorsManager.light;

    return BlocProvider(
      create: (_) => ImageZoomCubit(PhotoViewController()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            // backgroundColor: isDark ? ColorsManager.dark : ColorsManager.light,
            backgroundColor: AppColors.darka,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Center(
                  child: BlocBuilder<ImageZoomCubit, ImageZoomState>(
                    builder: (context, state) {
                      final cubit = context.read<ImageZoomCubit>();

                      return Transform.rotate(
                        angle:
                            state.rotationDegrees * (3.1415926535897932 / 180),
                        child: PhotoView(
                          controller: cubit.photoViewController,
                          imageProvider: NetworkImage(imageUrl),
                          backgroundDecoration: BoxDecoration(
                            // color: backgroundColor,
                            color: AppColors.darka
                          ),
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(Icons.broken_image, size: 100),
                              ),
                          loadingBuilder: (context, event) =>
                              const Center(child: CircularProgressIndicator()),
                          basePosition: Alignment.center,
                          enableRotation: false,
                          initialScale: PhotoViewComputedScale.contained,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.rotate_left,
                        onPressed: () =>
                            context.read<ImageZoomCubit>().rotateLeft(),
                      ),
                      _buildActionButton(
                        icon: Icons.rotate_right,
                        onPressed: () =>
                            context.read<ImageZoomCubit>().rotateRight(),
                      ),
                      _buildActionButton(
                        icon: Icons.replay,
                        onPressed: () => context.read<ImageZoomCubit>().reset(),
                      ),
                      _buildActionButton(
                        icon: Icons.share,
                        onPressed: () => Share.share(imageUrl),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return CircleAvatar(
      backgroundColor: Colors.black.withOpacity(0.7),
      radius: 24,
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24),
        onPressed: onPressed,
        splashRadius: 24,
      ),
    );
  }
}
