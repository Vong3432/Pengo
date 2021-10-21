import 'package:flutter/material.dart';
import 'package:pengo/models/item_validation_model.dart';
import 'package:pengo/ui/penger/items/widgets/requirement_list_item.dart';

class RequirementList extends StatelessWidget {
  const RequirementList({Key? key, required this.list}) : super(key: key);

  final List<BookingItemValidateMsg> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final BookingItemValidateMsg item = list[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RequirementListItem(requirement: item),
        );
      },
    );
  }
}
