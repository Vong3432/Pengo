import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pengo/bloc/goocard/goocard_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/lottie_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/ui/goocard/widgets/goocard.dart';
import 'package:pengo/ui/goocard/widgets/goocard_log_list.dart';
import 'package:pengo/ui/widgets/auth/login_user_only.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';

class GooCardPage extends StatefulWidget {
  const GooCardPage({Key? key}) : super(key: key);

  @override
  State<GooCardPage> createState() => _GooCardPageState();
}

class _GooCardPageState extends State<GooCardPage> {
  final GoocardBloc _goocardBloc = GoocardBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCard();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoocardBloc>(
      create: (BuildContext context) => _goocardBloc,
      child: Scaffold(
        backgroundColor: greyBgColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              title: Text(
                "Card",
                style: PengoStyle.navigationTitle(context),
              ),
            ),
            SliverFillRemaining(
              child: context.watch<AuthModel>().user == null
                  ? Container(
                      padding: EdgeInsets.only(
                        bottom: mediaQuery(context).size.height * 0.2,
                      ),
                      child: const LoginUserOnly(
                        text: "Login to unlock Goocard feature",
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GooCard(
                            bloc: _goocardBloc,
                          ),
                        ),
                        Expanded(
                          child: GooCardLogList(
                            bloc: _goocardBloc,
                            reload: _loadCard,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadCard() {
    _goocardBloc.add(
      const LoadGooCard(
        logLimit: 10,
        logs: 1,
        creditPoints: 1,
      ),
    );
  }
}
