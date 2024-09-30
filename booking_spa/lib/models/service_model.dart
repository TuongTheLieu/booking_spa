class ServiceModel {
  String? keySearch;
  String? image;
  String? title;
  int? price;
  String? sub;

  ServiceModel({this.keySearch, this.image, this.title, this.price, this.sub});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    keySearch = json['keySearch'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    sub = json['sub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keySearch'] = keySearch;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    data['sub'] = sub;
    return data;
  }
}
