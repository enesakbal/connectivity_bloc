class CatModel {
  String? id;
  String? url;

  CatModel({this.id, this.url});

  factory CatModel.fromMap(Map<String, dynamic> data) => CatModel(
        id: data['id'] as String?,
        url: data['url'] as String?,
      );
}
