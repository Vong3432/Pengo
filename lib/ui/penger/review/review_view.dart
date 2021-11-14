import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/models/review.dart';
import 'package:pengo/models/user_model.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/outlined_list_tile.dart';

class PengerReviewPage extends StatelessWidget {
  const PengerReviewPage({
    Key? key,
    required this.reviews,
    required this.penger,
  }) : super(key: key);

  final List<Review> reviews;
  final Penger penger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Reviews",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(content: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    OutlinedListTile(
                      title: penger.name,
                      subTitle: penger.description,
                      networkUrl: penger.logo,
                      leadingHeight: 52,
                      leadingWidth: 52,
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Reviews",
                          style: PengoStyle.header(context),
                        ),
                        const Spacer(),
                        Text(
                          "${reviews.length} review ${reviews.length > 1 ? "s" : ""}",
                        ),
                      ],
                    ),
                    _buildReviewList(),
                  ],
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }

  ListView _buildReviewList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: reviews.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          final Review review = reviews[index];
          return _buildReviewItem(review, context);
        });
  }

  Container _buildReviewItem(Review review, BuildContext context) {
    final User user = review.record!.goocard!.user!;
    final bool hasModified = review.createdAt != review.updatedAt;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 15,
                foregroundImage: NetworkImage(user.avatar),
              ),
              const SizedBox(
                width: SECTION_GAP_HEIGHT / 1.5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: PengoStyle.title2(context)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Reviewed on ${DateFormat("yyyy-MM-dd").format(review.updatedAt.toLocal())}",
                    style: PengoStyle.captionNormal(context)
                        .copyWith(color: grayTextColor),
                    textScaleFactor: 0.8,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 14,
              ),
              Flexible(
                flex: 2,
                child: SvgPicture.asset(
                  COMMENT_TREE_PATH,
                  width: 35,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      review.title,
                      style: PengoStyle.title2(context)
                          .copyWith(height: 1.4, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (review.description == null)
                      Container()
                    else
                      Text(
                        review.description.toString(),
                        style: PengoStyle.text(context)
                            .copyWith(color: grayTextColor),
                        textScaleFactor: 1,
                        textAlign: TextAlign.justify,
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
}
