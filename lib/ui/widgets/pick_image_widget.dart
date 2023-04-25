import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/create_button_state.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/cancel_button.dart';
import 'package:places/ui/widgets/place_icons.dart';

class PickImageWidget extends StatelessWidget {
  final List<Category> chosenCategory;
  final String titleValue;
  final String descriptionValue;
  final String latValue;
  final String lngValue;
  final List<XFile> imagesToUpload;
  const PickImageWidget({
    Key? key,
    required this.chosenCategory,
    required this.titleValue,
    required this.descriptionValue,
    required this.latValue,
    required this.lngValue,
    required this.imagesToUpload,
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
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  final ThemeData theme;

  const _DialogContent({
    Key? key,
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
  final ThemeData theme;

  const _DialogItems({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePlaceButtonCubit>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 4),
          _DialogItem(
            theme: theme,
            assetName: AppAssets.camera,
            title: AppStrings.camera,
            pickImage: () {
              cubit
                ..pickImageFromCamera()
                ..updateButtonState(
                  createButton: CreateButtonState(
                    chosenCategory: cubit.chosenCategory,
                    titleValue: cubit.name,
                    descriptionValue: cubit.description,
                    latValue: cubit.lat.toString(),
                    lngValue: cubit.lng.toString(),
                    imagesToUpload: cubit.imagesToUpload,
                  ),
                );
            },
          ),
          const Divider(),
          _DialogItem(
            theme: theme,
            assetName: AppAssets.photo,
            title: AppStrings.photo,
            pickImage: () {
              cubit
                ..pickImageFromGallery()
                ..updateButtonState(
                  createButton: CreateButtonState(
                    chosenCategory: cubit.chosenCategory,
                    titleValue: cubit.name,
                    descriptionValue: cubit.description,
                    latValue: cubit.lat.toString(),
                    lngValue: cubit.lng.toString(),
                    imagesToUpload: cubit.imagesToUpload,
                  ),
                );
            },
          ),
          const Divider(),
          _DialogItem(
            theme: theme,
            assetName: AppAssets.file,
            title: AppStrings.file,
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
