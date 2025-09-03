import 'package:dashboard_module/features/domain/usecases/db_usecases.dart';
import 'package:dashboard_module/features/presentation/cubit/db_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DBCubit extends Cubit<DBState> {
  final DbUseCase dbUseCase;

  DBCubit(this.dbUseCase) : super(GetCommentInitialState());

  getFeedData() async {
    try {
      emit(GetFeedDataLoadingState());
      final response = await dbUseCase.getFeedData();
      response.fold((f) {
        emit(GetFeedDataErrorState(errorMsg: f.message.toString()));
      }, (s) {
        emit(GetFeedDataLoadedState(feedEntity: s));
      });
    } catch (e) {
      emit(GetFeedDataErrorState(errorMsg: e.toString()));
    }
  }

  getComments() async {
    try {
      emit(GetCommentLoadingState());
      final response = await dbUseCase.getComments();
      response.fold((f) {
        emit(GetCommentErrorState(errorMsg: f.message.toString()));
      }, (s) {
        emit(GetCommentLoadedState(entity: s));
      });
    } catch (e) {
      emit(GetCommentErrorState(errorMsg: e.toString()));
    }
  }
}
