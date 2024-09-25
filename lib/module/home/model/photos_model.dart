class PhotosModel {

  String imgUrl;
  String photographerName;

  PhotosModel({required this.imgUrl, required this.photographerName});

  factory PhotosModel.fromJson(Map<String, dynamic>json)=>
      PhotosModel(
          imgUrl: (json['src'])['original'],
          photographerName: json['photographer']);
}