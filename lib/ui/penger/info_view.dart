import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconTheme.of(context),
            expandedHeight: MediaQuery.of(context).size.height * 0.05,
            backgroundColor: Colors.white,
            pinned: true,
            centerTitle: false,
            title: const Text(
              "Info",
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[],
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
                  children: <Widget>[Text("Info")],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
