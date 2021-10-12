class FavoritesModel {
  late bool status;
  late Data data;


  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['data'] != null){
      data = Data.fromJson(json['data']);
    }
  }

}

class Data {
  List<FavoritesData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(FavoritesData.fromJson(element));
      });
    }
  }
}

class FavoritesData {
  late int id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);

  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }

}
