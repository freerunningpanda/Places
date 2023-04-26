import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/search_appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';

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
      body: Padding(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddNewPlaceButton(),
    );
  }
}
