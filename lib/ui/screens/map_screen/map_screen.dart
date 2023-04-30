import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/search_appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final isSearchPage = context.read<PlacesListCubit>().isSearchPage;
    final readOnly = context.read<PlacesListCubit>().readOnly;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SearchAppBar(title: AppStrings.mapScreenTitle),
                const SizedBox(height: 16),
                SearchBar(
                  isMainPage: true,
                  isSearchPage: isSearchPage,
                  readOnly: readOnly,
                  searchController: TextEditingController(),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PlacesListCubit, PlacesListState>(
              builder: (context, state) {
                return state is PlacesListLoadedState
                    ? YandexMap(mapObjects: [
                        PlacemarkMapObject(
                          mapId: const MapObjectId('UUID'),
                          point: Point(
                            latitude: state.places[1].lat,
                            longitude: state.places[7].lng,
                          ),
                        ),
                      ])
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionWidget(
            assetName: AppAssets.refresh,
            onTap: () {},
          ),
          const AddNewPlaceButton(),
          ActionWidget(
            assetName: AppAssets.geolocation,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ActionWidget extends StatelessWidget {
  final String assetName;
  final VoidCallback onTap;
  const ActionWidget({
    Key? key,
    required this.assetName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: theme.tabBarTheme.labelColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PlaceIcons(
              assetName: assetName,
              width: 24,
              height: 24,
              color: theme.disabledColor,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
