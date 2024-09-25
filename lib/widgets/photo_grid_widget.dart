import 'package:flutter/material.dart';
import 'package:wall_app/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
class PhotoGridWidget extends StatelessWidget {
  final String photographerName;
  final String photo;
  final int tag;
  VoidCallback? onTap;
  PhotoGridWidget({super.key, required this.photographerName, required this.photo, required this.tag,this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GridTile(child: InkWell(
      onTap: onTap,
      child: Column(children: [
        Hero(
          tag: tag,
          child: Container(
            width: MediaQuery.of(context).size.width*0.5,
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
              //image: const DecorationImage(image: AssetImage('assets/images/placeholder.jpg'),fit: BoxFit.fill),

              borderRadius: BorderRadius.circular(20),
            ),
            child: CachedNetworkImage(

              imageUrl: photo,
              imageBuilder: (context, imageProvioder) {
                print('image load successfully $photo');
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvioder, fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(12)
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
          ),
        ),
        Text(photographerName,maxLines: 1,overflow: TextOverflow.ellipsis,)
      ],),
    ));
  }
}
