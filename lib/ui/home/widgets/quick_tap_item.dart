import 'package:flutter/material.dart';
import 'package:pengo/ui/penger/info_view.dart';

class QuickTapItem extends StatelessWidget {
  const QuickTapItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Just for navigation testing.
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => InfoPage()),
        // );
      },
      child: Column(
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: 50,
              height: 50),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text("Things 1"),
          ),
        ],
      ),
    );
  }
}
