import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_app/constants/app_colors.dart';
import 'package:wall_app/module/search/cubit/search_cubit.dart';
import 'package:wall_app/module/search/cubit/search_state.dart';
import 'package:wall_app/module/search/model/search_model.dart';

import '../../../repository/photos_repo.dart';
import '../../../widgets/photo_grid_widget.dart';
import '../../home/screens/image_screen.dart';

class SearchScreen extends StatelessWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    PhotosRepo searchRepo = PhotosRepo();
    return BlocProvider(
      create: (context) => SearchCubit(searchRepo),
      child: SearchView(
        searchedQuery: query,
      ),
    );
  }
}

class SearchView extends StatefulWidget {
  final String searchedQuery;

  const SearchView({super.key, required this.searchedQuery});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //final ScrollController _scrollController =ScrollController();
  @override
  void initState() {
    context.read<SearchCubit>().getSearchPhotos(widget.searchedQuery);
    //_scrollController.addListener(fetchMoreItems(widget.searchedQuery));
    super.initState();
  }

  /*fetchMoreItems(String query){
    if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent){
      context.read<SearchCubit>().getSearchPhotos(query);
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        widget.searchedQuery,
        style: const TextStyle(color: Colors.black, fontSize: 22),
        textAlign: TextAlign.center,
      ),),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.searchStatus == SearchStatus.initial) {
                  return const Center();
                } else if (state.searchStatus == SearchStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.searchStatus == SearchStatus.success) {
                  return GridView.builder(
                      //controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: (1 / 1.8),
                      ),
                      itemCount: state.search.length,
                      itemBuilder: (context, index) {
                        SearchModel search = state.search[index];
                        return PhotoGridWidget(
                          photographerName: search.altText,
                          photo: search.imgUrl,
                          tag: index,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageScreen(
                                          imgUrl: search.imgUrl,
                                          tag: index,
                                        )));
                          },
                        );
                      });
                } else {
                  return const Center(
                    child: Text(
                      'Failed to get Images',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}
