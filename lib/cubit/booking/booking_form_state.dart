part of 'booking_form_cubit.dart';

enum BookingFormStatus { initial, loading, failure, success }

class BookingFormState extends Equatable {
  const BookingFormState({
    this.startDate,
    this.endDate,
    this.bookTime,
    this.bookingItemId = 0,
    this.pengerId = 0,
    this.pin = "",
    this.range,
    this.status = BookingFormStatus.initial,
    this.progress = 0.0,
    this.hasPayment = false,
    this.hasStartDate = true,
    this.hasEndDate = true,
    this.hasTime = true,
    this.coupon,
  });

  BookingFormState copyWith({
    String? startDate,
    String? endDate,
    String? bookTime,
    int? bookingItemId,
    int? pengerId,
    String? pin,
    bool? hasPayment,
    bool? hasStartDate,
    bool? hasEndDate,
    bool? hasTime,
    double? latestProgress = 0.0,
    PickerDateRange? range,
    Coupon? coupon,
  }) {
    // Total conditon that needs to be checked.
    int totalCondition = 2;

    // Decrease total conditions based on item info
    // eg: Item's price is free, hence we don't need to show it in UI
    // if (hasPayment != true) totalCondition -= 1;
    if (hasTime != true) totalCondition -= 1;
    if (hasStartDate != true && hasEndDate != true) totalCondition -= 1;

    // Calculate progress per step
    // If totalCondition is zero, book button will show immediately without having
    // users to select date, time and pay.
    final double partialValue = totalCondition == 0 ? 1 : 1 / totalCondition;

    // Store latest progress
    double latestProgress = 0.0;

    if (hasTime == true && (bookTime != null || this.bookTime != null)) {
      latestProgress += partialValue;
    }

    if (hasStartDate == true) {
      final double partial = partialValue / 2;
      if (hasEndDate == true &&
          ((startDate != null && startDate.isNotEmpty) ||
              this.startDate != null)) {
        latestProgress += partial;
      } else if (hasEndDate == true &&
              (startDate == null || startDate.isEmpty) ||
          this.startDate == null) {
        latestProgress -= partial;
      } else {
        latestProgress += partialValue;
      }
    }

    if (hasEndDate == true) {
      final double partial = partialValue / 2;
      if (hasStartDate == true &&
          ((endDate != null && endDate.isNotEmpty) || this.endDate != null)) {
        latestProgress += partial;
      } else if (hasStartDate == true && (endDate == null || endDate.isEmpty) ||
          this.endDate == null) {
        latestProgress -= partial;
      } else {
        latestProgress += partialValue;
      }
    }

    if (hasTime != true && hasStartDate != true && hasEndDate != true) {
      latestProgress += 1;
    }

    return BookingFormState(
      bookingItemId: bookingItemId ?? this.bookingItemId,
      pin: pin ?? this.pin,
      pengerId: pengerId ?? this.pengerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      bookTime: bookTime ?? this.bookTime,
      progress: latestProgress,
      hasTime: hasTime ?? this.hasTime,
      hasPayment: hasPayment ?? this.hasPayment,
      hasStartDate: hasStartDate ?? this.hasStartDate,
      hasEndDate: hasEndDate ?? this.hasEndDate,
      range: range ?? this.range,
      coupon: coupon ?? this.coupon,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      "pin": pin,
      "penger_id": pengerId,
      "book_date": {
        "start_date": startDate,
        "end_date": endDate,
      },
      "book_time": bookTime,
      "booking_item_id": bookingItemId,
    };

    if (coupon != null) {
      map["coupon_id"] = coupon!.id;
    }
    return map;
  }

  final PickerDateRange? range;
  final String? startDate;
  final String? endDate;
  final String? bookTime;
  final int bookingItemId;
  final int pengerId;
  final String pin;
  final BookingFormStatus status;
  final double progress;
  final bool hasPayment;
  final bool hasStartDate;
  final bool hasEndDate;
  final bool hasTime;
  final Coupon? coupon;

  @override
  List<Object?> get props => [
        pin,
        bookTime,
        startDate,
        endDate,
        bookingItemId,
        pengerId,
        status,
        progress,
        hasStartDate,
        hasEndDate,
        hasTime,
        hasPayment,
        range,
        coupon,
      ];
}
