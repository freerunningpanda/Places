import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/cancel_button.dart';
import 'package:places/ui/widgets/place_icons.dart';

class PickImageWidget extends StatelessWidget {
  final VoidCallback imgFromCamera;
  final VoidCallback imgFromGallery;

  const PickImageWidget({
    Key? key,
    required this.imgFromCamera,
    required this.imgFromGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      alignment: const Alignment(0, 0.83),
      titlePadding: EdgeInsets.zero,
      title: _DialogContent(
        theme: theme,
        imgFromCamera: imgFromCamera,
        imgFromGallery: imgFromGallery,
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  final VoidCallback imgFromCamera;
  final VoidCallback imgFromGallery;
  final ThemeData theme;

  const _DialogContent({
    Key? key,
    required this.imgFromCamera,
    required this.imgFromGallery,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      height: 152,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _DialogItems(
            theme: theme,
            imgFromCamera: imgFromCamera,
            imgFromGallery: imgFromGallery,
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: -55,
            child: CancelButton(),
          ),
        ],
      ),
    );
  }
}

class _DialogItems extends StatelessWidget {
  final VoidCallback imgFromCamera;
  final VoidCallback imgFromGallery;
  final ThemeData theme;

  const _DialogItems({
    Key? key,
    required this.imgFromCamera,
    required this.imgFromGallery,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 4),
          _DialogItem(
            theme: theme,
            assetName: AppAssets.camera,
            title: AppString.camera,
            pickImage: imgFromCamera,
          ),
          const Divider(),
          _DialogItem(
            theme: theme,
            assetName: AppAssets.photo,
            title: AppString.photo,
            pickImage: imgFromGallery,
          ),
          const Divider(),
          _DialogItem(
            theme: theme,
            assetName: AppAssets.file,
            title: AppString.file,
            pickImage: () {},
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _DialogItem extends StatelessWidget {
  final ThemeData theme;
  final String assetName;
  final String title;
  final VoidCallback pickImage;
  const _DialogItem({
    Key? key,
    required this.theme,
    required this.assetName,
    required this.title,
    required this.pickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            PlaceIcons(assetName: assetName, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: theme.textTheme.displayLarge,
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: pickImage,
            ),
          ),
        ),
      ],
    );
  }
}
