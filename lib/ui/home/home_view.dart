import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.05,
            backgroundColor: Colors.white,
            pinned: true,
            centerTitle: false,
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
            actions: <IconButton>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.qr_code_scanner_outlined),
              )
            ],
            actionsIconTheme: const IconThemeData(color: Colors.black),
            textTheme:
                TextTheme(headline1: Typography.blackCupertino.headline1),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    const Text('This is home page.'),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
