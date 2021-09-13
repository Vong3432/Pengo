part of 'booking_category_bloc.dart';

abstract class BookingCategoryState extends Equatable {
  const BookingCategoryState();

  @override
  List<Object> get props => [];
}

class BookingCategoriesInitial extends BookingCategoryState {}

class BookingCategoriesLoading extends BookingCategoryState {}

class BookingCategoriesLoaded extends BookingCategoryState {
  const BookingCategoriesLoaded(this.categories);
  final List<BookingCategory> categories;
}

class BookingCategoriesNotLoaded extends BookingCategoryState {}

class BookingCategoryInitial extends BookingCategoryState {}

class BookingCategoryLoading extends BookingCategoryState {}

class BookingCategoryLoaded extends BookingCategoryState {}

class BookingCategoryNotLoaded extends BookingCategoryState {}
