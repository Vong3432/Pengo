// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    id: json['id'] as int?,
    title: json['title'] as String,
    description: json['description'] as String?,
    minCreditPoints: (json['min_credit_points'] as num?)?.toDouble(),
    requiredCreditPoints: (json['required_credit_points'] as num?)?.toDouble(),
    validFrom: json['valid_from'] as String,
    validTo: json['valid_to'] as String,
    quantity: json['quantity'] as int,
    isRedeemable: json['is_redeemable'] as bool,
    itemIds: (json['only_to_items'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
    bookingItems: (json['booking_items'] as List<dynamic>?)
        ?.map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    discountPercentage: (json['discount_percentage'] as num).toDouble(),
    createdBy: json['created_by'] == null
        ? null
        : Penger.fromJson(json['created_by'] as Map<String, dynamic>),
    afterCp: (json['after_redeem_cp'] as num?)?.toDouble(),
    currentCp: (json['current_cp'] as num?)?.toDouble(),
    isOwned: json['is_owned'] as bool?,
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'created_by': instance.createdBy,
      'min_credit_points': instance.minCreditPoints,
      'required_credit_points': instance.requiredCreditPoints,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'discount_percentage': instance.discountPercentage,
      'quantity': instance.quantity,
      'is_redeemable': instance.isRedeemable,
      'only_to_items': instance.itemIds,
      'booking_items': instance.bookingItems,
      'current_cp': instance.currentCp,
      'after_redeem_cp': instance.afterCp,
      'is_owned': instance.isOwned,
    };
