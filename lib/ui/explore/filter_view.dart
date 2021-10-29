import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/explore/cubit/filter_cubit.dart';
import 'package:pengo/ui/explore/widgets/filter/km_row.dart';
import 'package:pengo/ui/explore/widgets/filter/sort_row.dart';
import 'package:pengo/ui/explore/widgets/filter/type_row.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/extensions/string_extension.dart';

class ExploreFilterView extends StatefulWidget {
  const ExploreFilterView({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final FilterCubit cubit;

  @override
  ExploreFilterViewState createState() => ExploreFilterViewState();
}

class ExploreFilterViewState extends State<ExploreFilterView> {
  ExploreListFilter _type = ExploreListFilter.items;
  ExploreListSorting? _sort;
  int? _km;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _type = widget.cubit.state.filterType;
      _sort = widget.cubit.state.sortBy;
      _km = widget.cubit.state.km;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Container(),
            actions: <Widget>[
              CupertinoButton(
                onPressed: _submit,
                child: const Text("Done"),
              ),
            ],
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Filter",
                      style: PengoStyle.navigationTitle(context).copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: SECTION_GAP_HEIGHT),
                    TypeRow(
                      type: _type,
                      onTypeTapped: _typeChanged,
                    ),
                    const SizedBox(height: SECTION_GAP_HEIGHT),
                    SortRow(
                      onSortTapped: _sortChanged,
                      sort: _sort,
                    ),
                    const SizedBox(height: SECTION_GAP_HEIGHT),
                    KmRow(
                      onKmTapped: _kmChanged,
                      km: _km,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _typeChanged(ExploreListFilter t) {
    setState(() {
      _type = t;
    });
  }

  void _sortChanged(ExploreListSorting t) {
    // deselect if sort is previously selected.
    setState(() {
      _sort = (_sort != t) ? t : null;
    });
  }

  void _kmChanged(int t) {
    // deselect if km is previously selected.
    setState(() {
      _km = (_km != t) ? t : null;
    });
  }

  void _submit() {
    widget.cubit.filter(
      filterType: _type,
      sortBy: _sort,
      km: _km,
    );
    Navigator.pop(context);
  }
}
