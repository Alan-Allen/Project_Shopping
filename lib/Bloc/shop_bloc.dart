import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final CountRepository _countRepository;

  ShopBloc({required CountRespository countRespository})
    : _countRepository = countRespository,
        super(ShopInitial());
}

