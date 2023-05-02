import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/providers/theme_data_provider.dart';
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
  late YandexMapController controller;
  GlobalKey mapKey = GlobalKey();

  Future<bool> get locationPermissionNotGranted async => !(await Permission.location.request().isGranted);

  @override
  Widget build(BuildContext context) {
    final isSearchPage = context.read<PlacesListCubit>().isSearchPage;
    final isDarkMode = context.read<ThemeDataProvider>().isDarkMode;
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
                    ? YandexMap(
                        key: mapKey,
                        onMapCreated: (yandexMapController) async {
                          controller = yandexMapController;
                        },
                        onUserLocationAdded: (view) async {
                          return view.copyWith(
                            pin: view.pin.copyWith(
                              icon: PlacemarkIcon.single(
                                PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/user.png')),
                              ),
                            ),
                            arrow: view.arrow.copyWith(
                              icon: PlacemarkIcon.single(
                                PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/arrow.png')),
                              ),
                            ),
                            accuracyCircle: view.accuracyCircle.copyWith(
                              fillColor: Colors.green.withOpacity(0.5),
                            ),
                          );
                        },
                        mapObjects: [
                          for (var i = 0; i < state.places.length; i++)
                            PlacemarkMapObject(
                              mapId: MapObjectId(state.places[i].name),
                              point: Point(
                                latitude: state.places[i].lat,
                                longitude: state.places[i].lng,
                              ),
                              onTap: (mapObject, point) {
                                debugPrint('${state.places[i].name} tapped');
                              },
                            ),
                        ],
                        nightModeEnabled: isDarkMode,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
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
            onTap: () async {
              if (await locationPermissionNotGranted) {
                // ignore: use_build_context_synchronously
                _showMessage(context, const Text('Location permission was NOT granted'));

                return;
              }

              // ignore: use_build_context_synchronously
              final mediaQuery = MediaQuery.of(context);
              final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
              final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;

              await controller.toggleUserLayer(
                visible: true,
                autoZoomEnabled: true,
                anchor: UserLocationAnchor(
                  course: Offset(width * 0.5, height * 0.5),
                  normal: Offset(width * 0.5, height * 0.5),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showUserGeo() async {

  }

  void _showMessage(BuildContext context, Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
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
