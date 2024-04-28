part of 'shop_bloc.dart';

@immutable
sealed class ShopEvent {
  const ShopEvent();

  List<Object> get props => [];
}

class IncrementEvent extends ShopEvent {
  final int count;

  const IncrementEvent(this.count);

  @override
  String toString() => 'IncrementEvent(count: $count)';
}

class DecrementEvent extends ShopEvent {
  final int count;

  const DecrementEvent(this.count);

  @override
  String toString() => 'DecrementEvent(count: $count)';
}