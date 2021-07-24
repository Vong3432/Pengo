import 'package:flutter/material.dart';
import 'package:pengo/ui/penger/info_view.dart';

class PengerItem extends StatelessWidget {
  const PengerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoPage()),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 23,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iKIWgaiJUtss/v2/-1x-1.jpg"),
                    radius: 20,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text("Penger name", style: textTheme.caption),
              ],
            ),
          )
        ],
      ),
    );
  }
}
