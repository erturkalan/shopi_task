import 'network.dart';

class Request {
  int pageNumber = 0;
  int sortNumber = 5;

  Future<dynamic> getItemData(
      String item, int pageNumber, int sortNumber) async {
    var url =
        'https://dev.shopiconnect.com/api/product/search?categoryId=0&phrase=$item&page=$pageNumber&pageSize=8&sort=$sortNumber';
    NetworkHelper networkHelper = NetworkHelper(url);

    var itemData = await networkHelper.getData();
    return itemData;
  }
}
