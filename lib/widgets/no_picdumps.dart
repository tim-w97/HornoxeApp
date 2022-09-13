import 'package:flutter/material.dart';

class NoPicdumps extends StatelessWidget {
  const NoPicdumps({Key? key}) : super(key: key);

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
              "There are no picdumps available. \nPlease try again later. 🐂",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
