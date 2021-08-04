import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pengo/app.dart';

import 'main.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: <PageViewModel>[
          PageViewModel(
            title: "Welcome to Pengo",
            decoration: const PageDecoration(
              fullScreen: true,
            ),
            bodyWidget: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.category_outlined),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text("Standardized booking"),
                        Text(
                          "Discover and find places to book with fingertips.",
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            footer: SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const MyHomePage()));
                },
                color: Theme.of(context).primaryColor,
                child: const Text("Next"),
              ),
            ),
          ),
        ],
        showNextButton: false,
        isProgress: false,
        showDoneButton: false,
        onDone: () {
          // When done button is press
        },
      ),
    );
  }
}
