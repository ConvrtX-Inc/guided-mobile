import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_place/google_place.dart';
import 'package:guided/constants/app_colors.dart';

/// Search Place Screen
class SearchPlace extends StatefulWidget {
  ///Constructor
  const SearchPlace({Key? key}) : super(key: key);

  @override
  _SearchPlaceState createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  GooglePlace googlePlace =
      GooglePlace('AIzaSyDhlx9ZqFGUgyhlvPFxGMm3qCVglblq6dE');

  List<AutocompletePrediction> predictions = [];

  String _query = '';

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _searchFocusNode.requestFocus();
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> onSearch() async {
    final AutocompleteResponse? result =
        await googlePlace.autocomplete.get(_query);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }


  Future<void> getPlaceDetails(String placeId) async {
    final DetailsResponse? result = await googlePlace.details.get(placeId);
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (val) {
                    setState(() {
                      _query = val.trim();
                    });
                    onSearch();
                  },
                  focusNode: _searchFocusNode,
                  cursorColor: Colors.black,
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none),
                      filled: true,
                      contentPadding: const EdgeInsets.all(22),
                      fillColor: AppColors.gallery,
                      prefixIcon: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _query = '';
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            )
                          : null),
                ),
                if (predictions.isNotEmpty)
                  Expanded(child: buildSearchResults()),
                if (predictions.isEmpty && _query.isNotEmpty)
                  const Expanded(
                      child: Center(child: Text('No results found.')))
              ],
            )));
  }

  Widget buildSearchResults() => ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return buildSearchItem(predictions[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: predictions.length);

  Widget buildSearchItem(AutocompletePrediction searchResult) => Container(
        child: ListTile(
          onTap: () => getPlaceDetails(searchResult.placeId!),
          leading: const Icon(Icons.location_on),
          title: Text(
            searchResult.description!,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );


}
