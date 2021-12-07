import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';

class AppCubite extends Cubit<AppCubiteStates> {
  AppCubite() : super(AppInitialState());

  static AppCubite get(context) => BlocProvider.of(context);
  String lessonId = '';
  List<String> time = [];
  List<String> day = [];
  String timeselected = '';
  String dayselected = '';

  void changeId({required String id}) {
    lessonId = id;
    emit(Changeid());
  }

  void changetime({required String updatedTime}) {
    timeselected = updatedTime;
    emit(UpdateTime());
  }

  void changeday({required String updatedDay}) {
    dayselected = updatedDay;
    emit(UpdateDay());
  }
}
