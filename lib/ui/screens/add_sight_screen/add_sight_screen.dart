import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';

import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/providers/category_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/add_sight_screen/choose_category_screen.dart';
import 'package:places/ui/widgets/create_button.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/pick_image_widget.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:places/ui/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

String name = '';
double lat = 0;
double lot = 0;
String details = '';
String type = '';

class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final latController = context.read<PlaceInteractor>().latController;
    final lotController = context.read<PlaceInteractor>().lotController;
    final latFocus = context.read<PlaceInteractor>().latFocus;
    final lotFocus = context.read<PlaceInteractor>().lotFocus;
    final titleController = context.read<PlaceInteractor>().titleController;
    final descriptionController = context.read<PlaceInteractor>().descriptionController;
    final titleFocus = context.read<PlaceInteractor>().titleFocus;
    final descriptionFocus = context.read<PlaceInteractor>().descriptionFocus;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final chosenCategory = CategoryProvider.chosenCategory;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                NewPlaceAppBarWidget(
                  theme: theme,
                  width: width / 4.5,
                  leading: _CancelButtonWidget(theme: theme),
                  title: AppString.newPlace,
                ),
                const SizedBox(height: 40),
                _ImagePickerWidget(theme: theme),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CategoryChooseWidget(theme: theme),
                        const SizedBox(height: 16),
                        _TextInputWidget(
                          theme: theme,
                          title: AppString.title,
                          height: 40,
                          suffixIcon: SuffixIcon(controller: titleController, theme: theme),
                          focusNode: titleFocus,
                          controller: titleController,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (value) => latFocus.requestFocus(),
                          onChanged: (value) => name = value,
                        ),
                        const SizedBox(height: 24),
                        _CoordinatsInputWidget(
                          latController: latController,
                          lotController: lotController,
                          theme: theme,
                          latFocus: latFocus,
                          lotFocus: lotFocus,
                        ),
                        const SizedBox(height: 15),
                        const _PointOnMapWidget(),
                        const SizedBox(height: 37),
                        _TextInputWidget(
                          theme: theme,
                          title: AppString.description,
                          hintText: AppString.enterTheText,
                          maxLines: 5,
                          height: 80,
                          focusNode: descriptionFocus,
                          controller: descriptionController,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) => details = value,
                        ),
                        SizedBox(height: height * 0.18),
                        CreateButton(
                          title: AppString.create,
                          onTap: () {
                            debugPrint('🟡---------create btn pressed');
                            PlaceInteractor(apiPlaceRepository: ApiPlaceRepository()).addNewPlace(
                              place: Place(
                                id: 0,
                                urls: [''],
                                name: name,
                                lat: lat,
                                lon: lot,
                                description: details,
                                placeType: chosenCategory[0].title,
                              ),
                            );
                            titleController.clear();
                            descriptionController.clear();
                            latController.clear();
                            lotController.clear();
                            debugPrint('🟡---------Создан объект: ${PlaceInteractor.newPlaces.toList()}');
                            context.read<CategoryProvider>().clearCategory(activeCategories: chosenCategory);
                          },
                          titleController: titleController,
                          latController: latController,
                          lotController: lotController,
                          descriptionController: descriptionController,
                          chosenCategory: chosenCategory,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagePickerWidget extends StatefulWidget {
  final ThemeData theme;
  const _ImagePickerWidget({Key? key, required this.theme}) : super(key: key);

  @override
  State<_ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<_ImagePickerWidget> {
  // TODO(Alex): rewrite.
  final sightList = PlaceInteractor.favoritePlaces;
  @override
  Widget build(BuildContext context) {
    final places = context.watch<PlaceInteractor>().places;

    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Row(
            children: [
              _PickImageWidget(theme: widget.theme, places: places),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    for (var i = 0; i < places.length; i++)
                      _ImageSight(
                        image: places[i].urls[0],
                        index: i,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSight extends StatelessWidget {
  final String? image;
  final int index;
  const _ImageSight({Key? key, required this.image, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightContent(image: image, index: index);
  }
}

class _SightContent extends StatelessWidget {
  final String? image;
  final int index;
  const _SightContent({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.vertical,
      key: UniqueKey(),
      onDismissed: (direction) => context.read<PlaceInteractor>().removeImage(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.network(
                image ?? 'no_url',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
              const Positioned(
                top: 4,
                right: 4,
                child: SightIcons(assetName: AppAssets.clear, width: 24, height: 24),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => context.read<PlaceInteractor>().removeImage(index),
                    child: const SizedBox(height: 24, width: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Class for image picking to horizontal list
class _PickImageWidget extends StatelessWidget {
  final List<Place> places;
  final ThemeData theme;

  const _PickImageWidget({
    Key? key,
    required this.theme,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.sliderTheme.activeTickMarkColor as Color,
          width: 2,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.add_rounded, size: 45),
        onPressed: () async {
          // context.read<AppSettings>().pickImage();
          await showDialog<PickImageWidget>(
            context: context,
            builder: (_) {
              return const PickImageWidget();
            },
          );
        },
        color: theme.sliderTheme.activeTrackColor,
      ),
    );
  }
}

class _CancelButtonWidget extends StatelessWidget {
  final ThemeData theme;

  const _CancelButtonWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.pop(context),
      child: Text(
        AppString.cancel,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}

class _TextInputWidget extends StatefulWidget {
  final ThemeData theme;
  final String? hintText;
  final String title;
  final int? maxLines;
  final double height;
  final FocusNode focusNode;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  const _TextInputWidget({
    Key? key,
    required this.theme,
    this.hintText,
    required this.title,
    this.maxLines,
    required this.height,
    required this.focusNode,
    this.suffixIcon,
    required this.controller,
    required this.textInputAction,
    required this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<_TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<_TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: widget.theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: widget.height,
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            textCapitalization: TextCapitalization.sentences,
            cursorColor: widget.theme.focusColor,
            cursorWidth: 1,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTypography.textText16Search,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: widget.theme.sliderTheme.overlayColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.theme.sliderTheme.overlayColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: widget.focusNode.hasFocus ? widget.suffixIcon : null,
            ),
            onSubmitted: widget.onSubmitted,
          ),
        ),
      ],
    );
  }
}

class _PointOnMapWidget extends StatelessWidget {
  const _PointOnMapWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppString.pointOnTheMap,
      style: AppTypography.clearButton,
    );
  }
}

class _CoordinatsInputWidget extends StatelessWidget {
  final ThemeData theme;
  final TextEditingController latController;
  final TextEditingController lotController;
  final FocusNode latFocus;
  final FocusNode lotFocus;

  const _CoordinatsInputWidget({
    Key? key,
    required this.theme,
    required this.latController,
    required this.lotController,
    required this.latFocus,
    required this.lotFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = context.watch<PlaceInteractor>();

    return Row(
      children: [
        Expanded(
          child: _LatLotWidget(
            focusNode: latFocus,
            theme: theme,
            title: AppString.lat,
            onSubmitted: (v) => focus.goToLat(),
            controller: latController,
            onTap: focus.tapOnLat,
            onChanged: (value) {
              if (double.tryParse(value) != null) {
                lat = double.parse(value);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _LatLotWidget(
            focusNode: lotFocus,
            theme: theme,
            title: AppString.lot,
            onSubmitted: (v) => focus.goToDescription(),
            controller: lotController,
            onTap: focus.tapOnLot,
            onChanged: (value) {
              if (double.tryParse(value) != null) {
                lot = double.parse(value);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _LatLotWidget extends StatefulWidget {
  final ThemeData theme;
  final String title;
  final FocusNode focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;
  final VoidCallback onTap;
  final ValueChanged<String>? onChanged;

  const _LatLotWidget({
    Key? key,
    required this.theme,
    required this.title,
    required this.focusNode,
    required this.onSubmitted,
    required this.controller,
    required this.onTap,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_LatLotWidget> createState() => _LatLotWidgetState();
}

class _LatLotWidgetState extends State<_LatLotWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              widget.title,
              style: widget.theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: TextField(
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: widget.controller,
            cursorColor: widget.theme.focusColor,
            cursorWidth: 1,
            style: widget.theme.textTheme.bodyLarge,
            textInputAction: TextInputAction.next,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 16.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: widget.theme.sliderTheme.overlayColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.theme.sliderTheme.overlayColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: widget.focusNode.hasFocus
                  ? SuffixIcon(
                      controller: widget.controller,
                      theme: widget.theme,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryChooseWidget extends StatelessWidget {
  final ThemeData theme;

  const _CategoryChooseWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<CategoryProvider>().updateCategory();

    return Column(
      children: [
        Row(
          children: [
            Text(
              AppString.category.toUpperCase(),
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 14),
        InkWell(
          onTap: () => Navigator.of(context).push<ChooseCategoryWidget>(
            MaterialPageRoute(
              builder: (context) => const ChooseCategoryWidget(),
            ),
          ),
          child: SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (CategoryProvider.chosenCategory.isEmpty)
                  Text(
                    AppString.nochoose,
                    style: theme.textTheme.titleMedium,
                  )
                else
                  Text(
                    CategoryProvider.chosenCategory[0].title,
                    style: theme.textTheme.titleMedium,
                  ),
                const Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
