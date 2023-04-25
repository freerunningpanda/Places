import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:places/blocs/choose_category_bloc/choose_category_bloc.dart';
import 'package:places/cubits/add_place_screen/add_place_screen_cubit.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/cubits/image_provider/image_provider_cubit.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_model.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/create_button_state.dart';
import 'package:places/data/repository/category_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/add_place_screen/choose_category_screen.dart';
import 'package:places/ui/widgets/create_button.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/pick_image_widget.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/suffix_icon.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final categoryRepository = CategoryRepository();
  final latController = TextEditingController();
  final lotController = TextEditingController();
  final latFocus = FocusNode();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();

  final titleFocus = FocusNode();
  final searchFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final lotFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    final focus = context.read<AddPlaceScreenCubit>();
    final createPlaceBtnCubit = context.read<CreatePlaceButtonCubit>();
    final addPlaceScreenCubit = context.read<AddPlaceScreenCubit>();

    context.watch<CreatePlaceButtonCubit>().updateButtonState(
          createButton: CreateButtonState(
            titleValue: titleController.text,
            chosenCategory: createPlaceBtnCubit.chosenCategory,
            descriptionValue: descriptionController.text,
            latValue: latController.text,
            lngValue: lotController.text,
            imagesToUpload: createPlaceBtnCubit.imagesToUpload,
          ),
        );

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
                  title: AppStrings.newPlace,
                ),
                const SizedBox(height: 40),
                _ImagePickerWidget(theme: theme),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CategoryChooseWidget(
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        _TextInputWidget(
                          theme: theme,
                          title: AppStrings.title,
                          height: 40,
                          suffixIcon: SuffixIcon(controller: titleController, theme: theme),
                          focusNode: titleFocus,
                          controller: titleController,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (value) => focus.goToLat(latFocus: latFocus),
                          onChanged: (value) => createPlaceBtnCubit.name = value,
                        ),
                        const SizedBox(height: 24),
                        _CoordinatsInputWidget(
                          latController: latController,
                          lotController: lotController,
                          theme: theme,
                          latFocus: latFocus,
                          lotFocus: lotFocus,
                          descriptionFocus: descriptionFocus,
                        ),
                        const SizedBox(height: 15),
                        const _PointOnMapWidget(),
                        const SizedBox(height: 37),
                        _TextInputWidget(
                          theme: theme,
                          title: AppStrings.description,
                          hintText: AppStrings.enterTheText,
                          maxLines: 5,
                          height: 80,
                          focusNode: descriptionFocus,
                          controller: descriptionController,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) => createPlaceBtnCubit.description = value,
                        ),
                        SizedBox(height: height * 0.18),
                        CreateButton(
                          title: AppStrings.create,
                          onTap: () {
                            debugPrint('🟡---------create btn pressed');
                            createPlaceBtnCubit
                              ..addNewPlace(
                                PlaceModel(
                                  lat: createPlaceBtnCubit.lat,
                                  lng: createPlaceBtnCubit.lng,
                                  name: createPlaceBtnCubit.name,
                                  urls: createPlaceBtnCubit.uploadedImages,
                                  placeType: addPlaceScreenCubit.chosenCategories[0].placeType,
                                  description: createPlaceBtnCubit.description,
                                ),
                              )
                              // После добавления места, отправляю пустые данные в поля, чтобы сменить состояние
                              // кнопки на неактивную
                              ..updateButtonState(
                                createButton: CreateButtonState(
                                  chosenCategory: [],
                                  titleValue: '',
                                  descriptionValue: '',
                                  latValue: '',
                                  lngValue: '',
                                  imagesToUpload: [],
                                ),
                              );
                            // Для обновления состояния кнопки "Создать"
                            clearControllers();

                            debugPrint('🟡---------Создан объект: ${PlaceInteractor.newPlaces.toList()}');
                            // Меняю isEnabled в выбранной категории на false и затем очищаю список
                            context.read<ChooseCategoryBloc>().resetCategoryState(
                                  activeCategories: createPlaceBtnCubit.chosenCategory,
                                );
                            // Из-за очищенного выше списка в isEmpty упадёт true
                            // Для перерисовки состоянии категории на "Не выбрано"
                            context.read<ChooseCategoryBloc>().add(
                                  UnchosenCategoryEvent(
                                    isEmpty: createPlaceBtnCubit.chosenCategory.isEmpty,
                                  ),
                                );
                          },
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

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    latController.clear();
    lotController.clear();
  }
}

class _ImagePickerWidget extends StatefulWidget {
  final ThemeData theme;
  const _ImagePickerWidget({Key? key, required this.theme}) : super(key: key);

  @override
  State<_ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<_ImagePickerWidget> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePlaceButtonCubit>();

    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Row(
            children: [
              _PickImageWidget(
                theme: widget.theme,
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<CreatePlaceButtonCubit, CreatePlaceButtonState>(
              builder: (context, state) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < cubit.imagesToUpload.length; i++)
                          _ImagePlace(
                            image: cubit.imagesToUpload[i],
                            index: i,
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePlace extends StatelessWidget {
  final XFile? image;
  final int index;
  const _ImagePlace({Key? key, required this.image, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PlaceContent(image: image, index: index);
  }
}

class _PlaceContent extends StatelessWidget {
  final XFile? image;
  final int index;
  const _PlaceContent({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePlaceButtonCubit>();

    return Dismissible(
      direction: DismissDirection.vertical,
      key: UniqueKey(),
      onDismissed: (direction) {
        cubit
          ..removeImage(index: index)
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.file(
                File(image!.path).absolute,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (_, error, stackTrace) => const Icon(Icons.error),
              ),
              const Positioned(
                top: 4,
                right: 4,
                child: PlaceIcons(assetName: AppAssets.clear, width: 24, height: 24),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      cubit
                        ..removeImage(index: index)
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
  final ThemeData theme;

  const _PickImageWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePlaceButtonCubit>();

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
              return PickImageWidget(
                chosenCategory: cubit.chosenCategory,
                titleValue: cubit.name,
                descriptionValue: cubit.description,
                latValue: cubit.lat.toString(),
                lngValue: cubit.lng.toString(),
                imagesToUpload: cubit.imagesToUpload,
              );
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
        AppStrings.cancel,
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
      AppStrings.pointOnTheMap,
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
  final FocusNode descriptionFocus;

  const _CoordinatsInputWidget({
    Key? key,
    required this.theme,
    required this.latController,
    required this.lotController,
    required this.latFocus,
    required this.lotFocus,
    required this.descriptionFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = context.read<AddPlaceScreenCubit>();
    final place = context.read<CreatePlaceButtonCubit>();

    return BlocBuilder<AddPlaceScreenCubit, AddPlaceScreenState>(
      builder: (_, state) {
        return Row(
          children: [
            Expanded(
              child: _LatLotWidget(
                focusNode: latFocus,
                theme: theme,
                title: AppStrings.lat,
                onSubmitted: (v) => focus.goToLot(lotFocus: lotFocus),
                controller: latController,
                onTap: focus.tapOnLat,
                onChanged: (value) {
                  if (double.tryParse(value) != null) {
                    place.lat = double.parse(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _LatLotWidget(
                focusNode: lotFocus,
                theme: theme,
                title: AppStrings.lot,
                onSubmitted: (v) => focus.goToDescription(descriptionFocus: descriptionFocus),
                controller: lotController,
                onTap: focus.tapOnLot,
                onChanged: (value) {
                  if (double.tryParse(value) != null) {
                    place.lng = double.parse(value);
                  }
                },
              ),
            ),
          ],
        );
      },
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
    final cubit = context.read<AddPlaceScreenCubit>();

    return Column(
      children: [
        Row(
          children: [
            Text(
              AppStrings.category.toUpperCase(),
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 14),
        InkWell(
          onTap: () => Navigator.of(context).push<ChooseCategoryWidget>(
            MaterialPageRoute(
              builder: (_) => ChooseCategoryWidget(
                chosenCategories: cubit.chosenCategories,
                categories: cubit.categories,
              ),
            ),
          ),
          child: SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ChooseCategoryBloc, ChooseCategoryState>(
                  builder: (_, state) {
                    return state.isEmpty
                        ? Text(AppStrings.nochoose, style: theme.textTheme.titleMedium)
                        // null быть не может, так как при сохранении категории она прокинется в стэйт
                        : Text(state.chosenCategory!.title, style: theme.textTheme.titleMedium);
                  },
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
