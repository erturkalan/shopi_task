import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopi_task/network/request.dart';
import 'package:shopi_task/util/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopi_task/widgets/loading_indicator.dart';
import 'package:shopi_task/widgets/product_list.dart';
import '../Model/product.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var wordController = TextEditingController();
  int tapCounter = 0;
  int toggleNumber = 2;
  bool isLoading = false;
  int pageNumber = 0;
  ScrollController scrollController = ScrollController();
  String message = '';
  String searchWord = '';
  int resultNumber;
  List products = [];
  int totalPageCount;
  int sortNumber = 5;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    searchWord = 'dress';
    updateUI(searchWord, pageNumber, sortNumber);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        _getMoreData();
      }
    });
  }

  void onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 243,
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 5,
                        width: 29,
                        decoration: BoxDecoration(
                            color: Color(0xFFD0D6DE),
                            borderRadius: BorderRadius.circular(2.5)),
                      ),
                    ),
                  ),
                  buildSortTile('Name: A to Z', context, 5),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(0xFFf0f0f0),
                  ),
                  buildSortTile('Name: Z to A', context, 6),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(0xFFf0f0f0),
                  ),
                  buildSortTile('Price: Low to High', context, 10),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(0xFFf0f0f0),
                  ),
                  buildSortTile('Price: High to Low', context, 11),
                ],
              ),
            ),
          );
        });
  }

  _getMoreData() {
    if (pageNumber <= (totalPageCount - 2) && isLoading) {
      setState(() {
        print(pageNumber);
        pageNumber++;
        updateUI(searchWord, pageNumber, sortNumber);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateUI(String item, int pageNumber, int sortNumber) async {
    if (this.sortNumber != sortNumber) {
      this.products.clear();
      this.sortNumber = sortNumber;
    }
    setState(() {
      if (pageNumber > 0) {
        isLoadingMore = true;
      } else {
        isLoadingMore = false;
      }
    });

    var itemData = await Request().getItemData(item, pageNumber, sortNumber);

    if (itemData != null) {
      isLoadingMore = false;
      setState(() {
        ProductListResponseModel productListResponseModel =
            ProductListResponseModel.fromJson(itemData);
        this.resultNumber = productListResponseModel.productNumber;
        this.totalPageCount = productListResponseModel.totalPageNumber;
        this.products.addAll(productListResponseModel.productList);
      });

      if (resultNumber == null) {
        setState(() {
          products = [];
          message = 'No products found.';
        });
      } else {
        setState(() {
          message = '$resultNumber RESULTS FOR "${searchWord.toUpperCase()}"';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 57, 15, 15),
              height: 96,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          print('back button was pressed.');
                        },
                        child: SvgPicture.asset(
                          'assets/icons/left.svg',
                          height: 24,
                          width: 24,
                        )),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: wordController,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF16325c),
                      ),
                      decoration: kTextFieldInputDecoration,
                      onSubmitted: (String value) {
                        if (value != '') {
                          setState(() {
                            searchWord = value;
                            print(searchWord);
                            pageNumber = 0;
                            products.clear();
                            updateUI(searchWord, pageNumber, sortNumber);
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              wordController.clear();
                              message = '';
                              searchWord = '';
                              this.products.clear();
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/icons/iconsBasicDeleteConsole.svg',
                            height: 30,
                            width: 30,
                          ))),
                ],
              ),
            ),
            buildFilterRow(),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  message,
                  style: TextStyle(
                    color: kTextColour,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ProductList(
                scrollController: scrollController,
                products: products,
                toggleNumber: toggleNumber),
            LoadingIndicator(isLoadingMore: isLoadingMore),
          ],
        ),
      ),
    );
  }

  Widget buildSortTile(String sortName, BuildContext context, int sortNumber) {
    return ListTile(
      title: Text(sortName),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          pageNumber = 0;
          updateUI(searchWord, pageNumber, sortNumber);
        });
      },
    );
  }

  Widget buildFilterRow() {
    return Row(children: [
      Container(
          height: 44,
          width: 137,
          margin: EdgeInsets.fromLTRB(20, 16, 0, 0),
          padding: EdgeInsets.fromLTRB(34, 10, 34, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.white),
          child: Row(children: [
            SvgPicture.asset(
              'assets/icons/iconsBasicFilter.svg',
              height: 24,
              width: 23,
            ),
            Text(
              'Filter',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF16325c),
                  fontSize: 15),
            ),
          ])),
      SizedBox(
        width: 1,
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            onButtonPressed();
          });
        },
        child: Container(
            height: 44,
            width: 138,
            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            padding: EdgeInsets.fromLTRB(37, 10, 17, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.white),
            child: Row(children: [
              SvgPicture.asset(
                'assets/icons/sort.svg',
                height: 24,
                width: 23,
              ),
              Text(
                'Sort',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF16325c),
                    fontSize: 15),
              ),
            ])),
      ),
      SizedBox(
        width: 1,
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            tapCounter++;
            if (tapCounter % 2 == 1) {
              setState(() {
                toggleNumber = 1;
              });
            } else {
              setState(() {
                toggleNumber = 2;
              });
            }
          },
          child: Container(
            height: 44,
            width: 59,
            margin: EdgeInsets.fromLTRB(0, 16, 20, 0),
            padding: EdgeInsets.fromLTRB(18, 10, 17, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.white),
            child: SvgPicture.asset(
              'assets/icons/iconsOtherCardList.svg',
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    ]);
  }
}
