import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    @required this.isLoadingMore,
  }) : super(key: key);

  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 48,
            height: 48,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ))),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
