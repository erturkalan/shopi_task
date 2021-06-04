import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopi_task/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'request.dart';
import 'my_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int tapCounter = 0;
  int toggleNumber = 2;
  bool isLoading = false;
  int pageNumber = 0;
  ScrollController _scrollController = ScrollController();
  String message = '';
  String searchWord = '';
  int resultNumber;
  List products = [];
  int totalPageCount;
  int sortNumber = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        isLoading = true;
        _getMoreData();
      }
    });
  }

  void onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              ListTile(
                title: Text('Name: A to Z'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    sortNumber = 5;
                    updateUI(searchWord, pageNumber, sortNumber);
                  });
                },
              ),
              ListTile(
                title: Text('Name: Z to A'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    sortNumber = 6;
                    updateUI(searchWord, pageNumber, sortNumber);
                  });
                },
              ),
              ListTile(
                title: Text('Price: Low to High'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    sortNumber = 10;
                    updateUI(searchWord, pageNumber, sortNumber);
                  });
                },
              ),
              ListTile(
                title: Text('Price: High to Low'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    sortNumber = 11;
                    updateUI(searchWord, pageNumber, sortNumber);
                  });
                },
              ),
            ],
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
    var itemData = await Request().getItemData(item, pageNumber, sortNumber);
    setState(() {
      resultNumber = itemData['totalResultCount'];
      products = itemData['products'];
      totalPageCount = itemData['totalPageCount'];
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
                          print('back button was pressed');
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
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF16325c),
                      ),
                      decoration: kTextFieldInputDecoration,
                      onSubmitted: (String value) {
                        setState(() {
                          searchWord = value;
                          print(searchWord);
                          updateUI(searchWord, pageNumber, sortNumber);
                        });
                      },
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            print('delete button was pressed');
                          },
                          child: SvgPicture.asset(
                            'assets/icons/iconsBasicDeleteConsole.svg',
                            height: 30,
                            width: 30,
                          ))),
                ],
              ),
            ),
            Row(children: [
              Container(
                  height: 44,
                  width: 137,
                  margin: EdgeInsets.fromLTRB(20, 16, 0, 0),
                  padding: EdgeInsets.fromLTRB(34, 10, 34, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white),
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
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white),
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
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white),
                    child: SvgPicture.asset(
                      'assets/icons/iconsOtherCardList.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ]),
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: GridView.builder(
                  controller: _scrollController,
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.45,
                      crossAxisCount: toggleNumber,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return getCard(products[index]);
                  }),
            ))
          ],
        ),
      ),
    );
  }

  Widget getCard(item) {
    var headline = item['headline'];
    var productName = item['productName'];
    var listPrice = item['listPrice'];
    String price = listPrice.toString();
    var picture = item['picture']['url'];
    return MyCard(
        picture: picture,
        headline: headline,
        productName: productName,
        price: price);
  }
}
