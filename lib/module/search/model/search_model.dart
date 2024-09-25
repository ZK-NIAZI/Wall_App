class SearchModel {

  String imgUrl;
  String altText;

  SearchModel({required this.imgUrl, required this.altText});

  factory SearchModel.fromJson(Map<String, dynamic>json)=>
      SearchModel(
          imgUrl: (json['src'])['original'],
          altText: json['alt']);
}