import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/ui/booking-records/reviews/review_view.dart';
import 'package:pengo/ui/booking-records/widgets/booking_card.dart';
import 'package:pengo/ui/widgets/api/loading.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class PastRecordListPage extends StatefulWidget {
  const PastRecordListPage({Key? key}) : super(key: key);

  @override
  _PastRecordListPageState createState() => _PastRecordListPageState();
}

class _PastRecordListPageState extends State<PastRecordListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            centerTitle: true,
            shadowColor: secondaryTextColor,
            floating: true,
            elavation: 4,
            title: Text(
              "To review",
              style: PengoStyle.title2(context),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              BlocBuilder<BookingRecordBloc, BookingRecordState>(
                builder: (BuildContext context, BookingRecordState state) {
                  if (state is BookingRecordsLoading) {
                    return const LoadingWidget();
                  } else if (state is BookingRecordsLoaded) {
                    if (state.records.isEmpty) {
                      return const Center(
                        child: Text("You haven't booked any thing yet."),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          bottom: 28,
                          left: 12,
                          right: 12,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final BookingRecord record = state.records[index];
                          if (record.isReviewed == false) {
                            return BookingCard(
                              record: record,
                              onReview: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                )
                                    .push(
                                      CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                            RecordReviewPage(
                                          record: record,
                                        ),
                                      ),
                                    )
                                    .then((_) => _loadRecords());
                              },
                            );
                          }
                          return Container();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          );
                        },
                        itemCount: state.records.length,
                      );
                    }
                  }
                  return Container();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _loadRecords() {
    BlocProvider.of<BookingRecordBloc>(context).add(
      const FetchRecordsEvent(
        category: 1,
        isUsed: 1,
      ),
    );
  }
}
