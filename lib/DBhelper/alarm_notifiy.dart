import 'package:bloc/bloc.dart';
import 'package:elmanhag_app/cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AlarmNotify extends Cubit<AppCubiteStates> {
  AlarmNotify() : super(AppInitialState());

  static AlarmNotify get(context) => BlocProvider.of(context);
  List<Map> notifyData = [];
  late Database database;
  void createDb2() {
    openDatabase('notify.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE notify (id INTEGER PRIMARY KEY , day TEXT, time TEXT)')
          .then((value) {
        print(
            "database created successfully ================================================");
      }).catchError((error) {
        print(
            "error while creating DB --------------------------------- ${error.toString()}");
      });
    }, onOpen: (database) {
      getfromDataBase2(database);
    }).then((value) {
      database = value;
      emit(CreatedatabaseState2());
    });
  }
/////////////////////////////////////////////////////////////////////////

  getfromDataBase2(database) {
    emit(LoadingDatafromDatabase2());
    database.rawQuery('SELECT * FROM notify').then((value) {
      notifyData = value;
      emit(GetdatabaseState2());
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////

  deletaFromDB({required int notifyId}) {
    database.rawDelete('DELETE FROM notify WHERE id = ?', ['$notifyId']).then(
        (value) {
      getfromDataBase2(database);
      print("item deleted successfully from database -----------------------");
      emit(DeletedatabaseState());
    }).catchError((error) {
      print(
          "error while deleting item from DB --------------------------------- ${error.toString()}");
    });
  }

/////////////////////////////////////////////////////////////////////////////////////////////
  void inserttoDatabase2({
    required String day,
    required String time,
  }) async {
    database.transaction((txn) async {
      txn
          .rawInsert('INSERT INTO notify(day, time) VALUES("$day", "$time")')
          .then((value) {
        print("item addedd successfully from database -----------------------");

        emit(InsertdatabaseState2());
        getfromDataBase2(database);
        emit(GetdatabaseState2());
      }).catchError((error) {
        print(
            "error while insert item to  DB --------------------------------- ${error.toString()}");
      });
      return null;
    });
  }
  ///////////////////////////////////////////////////////////////////////////////////////////

}
