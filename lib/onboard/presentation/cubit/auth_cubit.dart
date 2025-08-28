import 'package:animal_app/onboard/data/models/ob_all_request_model.dart';
import 'package:animal_app/onboard/domain/usecases/ob_usecases.dart';
import 'package:animal_app/onboard/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final ObUseCase obUseCase;

  AuthCubit(this.obUseCase) : super(ObRegInitialState());

  register({required ObRegRequestModel request}) async {
    try {
      emit(ObRegLoadingState());
      final response = await obUseCase.register(request: request);
      response.fold(
        (f) {
          emit(ObRegErrorState(errorMsg: f.message.toString()));
        },
        (s) {
          emit(ObRegLoadedState(entity: s));
        },
      );
    } catch (e) {
      emit(ObRegErrorState(errorMsg: e.toString()));
    }
  }
}
