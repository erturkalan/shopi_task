class Product {
  String productName;
  String listPrice;
  String imageUrl;
  String headline;

  Product.fromJson(Map<String, dynamic> json) {
    this.productName = json["productName"];
    this.listPrice = json["listPrice"].toString();
    this.imageUrl = json["picture"]["url"];
    this.headline = json["headline"];
  }
}

class ProductListResponseModel {
  List<Product> productList;
  int totalPageNumber;
  int productNumber;

  ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    this.productNumber = json['totalResultCount'];
    this.totalPageNumber = json['totalPageCount'];

    final data = json["products"] as List;
    List<Product> tempProducts;

    tempProducts = data.map((jsonElement) => Product.fromJson(jsonElement)).toList();
    this.productList = tempProducts;
  }
}
