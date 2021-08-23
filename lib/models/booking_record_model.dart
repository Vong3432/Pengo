import 'package:pengo/models/booking_item_model.dart';

class BookingRecord {
  const BookingRecord({
    required this.id,
    required this.bookDate,
    required this.bookTime,
    required this.item,
    required this.goocardID,
    required this.pengerID,
  });

  factory BookingRecord.fromJson(dynamic json) {
    return BookingRecord(
      id: json['id'] as int,
      goocardID: json['penger_id'] as int,
      pengerID: json['goo_card_id'] as int,
      item: BookingItem.fromJson(json['item']),
      bookDate: json['book_date'].toString(),
      bookTime: json['book_time'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["id"] = id;
    map["goocard_id"] = goocardID;
    map["penger_id"] = pengerID;
    map["book_time"] = bookTime;
    map["book_date"] = bookDate;
    map["item"] = item.toMap();
    // Add all other fields
    return map;
  }

  final int id;
  final int goocardID;
  final int pengerID;
  final String bookTime;
  final String bookDate;
  final BookingItem item;
}
