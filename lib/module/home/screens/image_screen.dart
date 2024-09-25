import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wall_app/constants/app_colors.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:wall_app/widgets/bg_type_widget.dart';
import 'package:wall_app/widgets/loading_widget.dart';

class ImageScreen extends StatefulWidget {
  String imgUrl;
  int tag;

  ImageScreen({super.key, required this.imgUrl, required this.tag});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.tag,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [

              CachedNetworkImage(
                imageUrl: widget.imgUrl,
                imageBuilder: (context, imageProvioder) {
                  print('image load successfully ${widget.imgUrl}');
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvioder, fit: BoxFit.cover),
                    ),
                  );
                },
                placeholder: (context, url) => Container(
                  height: 250,
                  width: 164,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black,blurRadius: 20,)],
                      ))),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                downloadWallpaper();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
              child: const Text("Download",
                  style: TextStyle(color: AppColors.white)),
            ),
            const SizedBox(width: 10,),
            ElevatedButton(
              onPressed: () {
                BgTypeWidget(context,() {
                  Navigator.pop(context, false);
                  setHomeWallpaper();
                },() {
                  Navigator.pop(context, false);
                  setBothWallpaper();
                },
                );
                //setWallpaper();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
              child: const Text("Set As BackGround", style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> downloadWallpaper() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Downloading...")));
    LoadingWidget.show(context);
    try {
      var response = await Dio().get(widget.imgUrl,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "image: ${widget.tag}");
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Downloaded Successfully")));
        LoadingWidget.hide(context);
      }
      log(result);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occurred $e")));
      LoadingWidget.hide(context);
    }
  }

  Future<void> setHomeWallpaper() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Setting as WallPaper")));
    LoadingWidget.show(context);
    String result;
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: widget.imgUrl,
        goToHome: false,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
      LoadingWidget.hide(context);
      log(result);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
      log(result);
    }
  }
  Future<void> setBothWallpaper() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Setting as WallPaper")));
    LoadingWidget.show(context);
    String result;
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: widget.imgUrl,
        goToHome: false,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
      LoadingWidget.hide(context);
      log(result);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
      log(result);
    }
  }
}
