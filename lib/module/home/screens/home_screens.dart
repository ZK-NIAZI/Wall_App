import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_app/config/config.dart';
import 'package:wall_app/constants/app_colors.dart';
import 'package:wall_app/module/home/cubit/photo_cubit.dart';
import 'package:wall_app/module/home/cubit/photo_state.dart';
import 'package:wall_app/module/home/screens/image_screen.dart';
import 'package:wall_app/module/search/screen/search_screen.dart';
import 'package:wall_app/repository/photos_repo.dart';

import '../../../widgets/photo_grid_widget.dart';
import '../model/photos_model.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    PhotosRepo photosRepo = PhotosRepo();

    return  BlocProvider(
      create: (context) => PhotoCubit(photosRepo),
  child: const HomeView(),
);
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController =ScrollController();


  @override
  void initState() {
    _scrollController.addListener(fetchMoreItems);
    super.initState();
  }

  fetchMoreItems(){
    if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent){
      context.read<PhotoCubit>().getPhotos();
    }
  }
  @override
  void dispose() {
   _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'WallApp',
            style: TextStyle(color: Colors.white),
          )),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SearchBar(
              leading: const Icon(Icons.search_outlined),
              onSubmitted: (value) {
                NavRouter.push(context, SearchScreen(query: value));
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: BlocConsumer<PhotoCubit, PhotoState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state.photoStatus == PhotoStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.photoStatus == PhotoStatus.success) {
                    return GridView.builder(
                      controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              childAspectRatio: (1/1.9),
                            ),
                        itemCount: state.photos.length,
                        itemBuilder: (context, index) {
                          PhotosModel photos = state.photos[index];
                          return PhotoGridWidget(
                            photographerName: photos.photographerName,
                            photo: photos.imgUrl,
                            tag: index,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageScreen(
                                            imgUrl: photos.imgUrl,
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
            ),
          ),
        ],
      ),
    );
  }
}
