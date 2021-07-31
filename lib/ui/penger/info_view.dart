import 'package:flutter/material.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/ui/penger/booking/booking_view.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';
import 'package:pengo/ui/widgets/stacks/h_stack.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(context),
          _buildBody(context),
        ],
      ),
    );
  }

  SliverList _buildBody(BuildContext ctx) {
    final TextTheme textTheme = Theme.of(ctx).textTheme;

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 18,
          ),
          child: _buildPengerInfo(textTheme),
        ),
      ]),
    );
  }

  Column _buildPengerInfo(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Gelang Patah, Johor", style: textTheme.bodyText1),
            const Spacer(),
            const Icon(Icons.location_on_outlined),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        _buildPengerDetail(textTheme),
        const SizedBox(height: 20),
        _buildPengerImgs(),
        _buildTabBarView(context),
      ],
    );
  }

  Widget _buildTabBarView(BuildContext ctx) {
    final Size size = MediaQuery.of(ctx).size;
    final TextTheme textTheme = Theme.of(ctx).textTheme;

    return SizedBox(
      height: size.height,
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              //This is for bottom border that is needed
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: _generateTabBar,
            ),
          ),
          Flexible(
            child: TabBarView(
                controller: _tabController,
                // list.generate should be replaced with actual tabview.
                children: _generateTabView(textTheme)),
          ),
        ],
      ),
    );
  }

  List<Tab> get _generateTabBar {
    return const <Tab>[
      Tab(
        text: "Events",
      ),
      Tab(
        text: "Appointments",
      ),
      Tab(
        text: "Items",
      ),
      Tab(
        text: "Items",
      ),
      Tab(
        text: "Items",
      ),
    ];
  }

  List<Widget> _generateTabView(TextTheme textTheme) {
    return List.generate(
      5,
      (int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CustomListItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingView(
                  bookingItem: bookingItemsMockData[0],
                ),
              ),
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
            ),
          ),
          content: <Widget>[
            Text(
              "Durian Party Night",
              style: TextStyle(
                  fontSize: textTheme.subtitle1!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Impian emas",
                    style: textTheme.subtitle2,
                  ),
                ),
                Text("RM5.00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: textTheme.subtitle2!.fontSize,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _buildPengerDetail(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Penger name",
          style: textTheme.headline6,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Proin libero nunc consequat interdum varius sit amet. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget gravida",
            style: textTheme.bodyText2),
      ],
    );
  }

  SizedBox _buildPengerImgs() {
    return const SizedBox(
      height: 70,
      child: HStack(
        children: <Image>[
          Image(
            width: 70,
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
          ),
          Image(
            width: 70,
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
          ),
          Image(
            width: 70,
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
          ),
          Image(
            width: 70,
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconTheme.of(context),
      bottom: PreferredSize(
        preferredSize: const Size(0, 20),
        child: Container(),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      centerTitle: false,
      flexibleSpace: Stack(
        children: const <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://i.guim.co.uk/img/media/ac01822e1237b350779e9e41ab69c8bcc8d292ea/0_0_6016_3611/master/6016.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=e8ed1dcb5b915acb79446d4bf5202eac"),
            ),
          ),
        ],
      ),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(headline1: Typography.blackCupertino.headline1),
    );
  }
}
