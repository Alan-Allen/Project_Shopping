part of 'shop_bloc.dart';

@immutable
sealed class ShopState {
  const ShopState();
}

final class ShopInitial extends ShopState {}

class Success extends ShopState {
  final int count;

  const Success(this.count);

  List<Object> get props => [count];
}

class Failure extends ShopState {}