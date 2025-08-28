import 'package:dashboard_module/features/domain/usecases/db_usecases.dart';
import 'package:dashboard_module/features/presentation/cubit/db_sell_confirm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DbSellConfirmCubit extends Cubit<DBSellConfirmState> {
  final DbUseCase dbUseCase;

  DbSellConfirmCubit(this.dbUseCase) : super(SellConfirmInitialState());

  getConfirmation() async {
    try {
      emit(SellConfirmLoadingState());
      final response = await dbUseCase.getSellConfirmation();
      response.fold((f) {
        emit(SellConfirmErrorState(errorMsg: f.message.toString()));
      }, (s) {
        emit(SellConfirmLoadedState(entity: s));
      });
    } catch (e) {
      emit(SellConfirmErrorState(errorMsg: e.toString()));
    }
  }

  fieldValidate() async {}
}
