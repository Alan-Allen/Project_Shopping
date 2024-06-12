import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../count_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final CountRepository _countRepository;

  ShopBloc({required CountRepository countRepository})
      : _countRepository = countRepository,
        super(ShopInitial());

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is IncrementEvent) {
      yield* _mapIncrementToState(event.count);
    }
    if (event is DecrementEvent) {
      yield* _mapDecrementToState(event.count);
    }
  }

  Stream<ShopState> _mapIncrementToState(int count) async* {
    try {
      final _count = await _countRepository.add(count);
      yield Success(_count);
    } catch (_) {
      yield Failure();
    }
  }

  Stream<ShopState> _mapDecrementToState(int count) async* {
    try {
      final _count = await _countRepository.dec(count);
      yield Success(_count);
    } catch (_) {
      yield Failure();
    }
  }
}

