import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_item_model.dart';

part 'booking_record_model.g.dart';

@JsonSerializable()
class BookingRecord {
  const BookingRecord({
    required this.id,
    required this.bookDate,
    required this.bookTime,
    required this.item,
    required this.goocardID,
    required this.pengerID,
  });

  factory BookingRecord.fromJson(Map<String, dynamic> json) =>
      _$BookingRecordFromJson(json);
  Map<String, dynamic> toJson() => _$BookingRecordToJson(this);

  // {
  //   return BookingRecord(
  //     id: json['id'] as int,
  //     goocardID: json['penger_id'] as int,
  //     pengerID: json['goo_card_id'] as int,
  //     item: BookingItem.fromJson(json['item']),
  //     bookDate: json['book_date'].toString(),
  //     bookTime: json['book_time'].toString(),
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   final map = Map<String, dynamic>();
  //   map["id"] = id;
  //   map["goocard_id"] = goocardID;
  //   map["penger_id"] = pengerID;
  //   map["book_time"] = bookTime;
  //   map["book_date"] = bookDate;
  //   map["item"] = item.toMap();
  //   // Add all other fields
  //   return map;
  // }

  final int id;

  @JsonKey(name: 'goo_card_id')
  final int goocardID;

  @JsonKey(name: 'penger_id')
  final int pengerID;

  @JsonKey(name: 'book_time')
  final String bookTime;

  @JsonKey(name: 'book_date')
  final String bookDate;

  final BookingItem item;
}