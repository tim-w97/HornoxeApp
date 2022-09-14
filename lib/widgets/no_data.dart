import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/empty_horni.png", width: 200),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "There is nothing to see here. \nPlease try again later. 🐂",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
