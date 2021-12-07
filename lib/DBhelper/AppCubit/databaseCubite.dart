import 'package:elmanhag_app/cubit/app_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseCubit extends Cubit<AppCubiteStates> {
  DataBaseCubit() : super(AppInitialState());

  static DataBaseCubit get(context) => BlocProvider.of(context);

  late Database database;
  List<Map> sectiondata = [];
  Map<String, bool> isselected = {};

  void createDb() {
    openDatabase('sections.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE section (id INTEGER PRIMARY KEY , sectionTitle TEXT, sectionId TEXT)')
          .then((value) {
        print(
            "database created successfully ================================================");
      }).catchError((error) {
        print(
            "error while creating DB --------------------------------- ${error.toString()}");
      });
    }, onOpen: (database) {
      getfromDataBase(database);
    }).then((value) {
      database = value;
      emit(CreatedatabaseState());
    });
  }
/////////////////////////////////////////////////////////////////////////

  getfromDataBase(database) {
    emit(LoadingDatafromDatabase());
    database.rawQuery('SELECT * FROM section').then((value) {
      sectiondata = value;
      emit(GetdatabaseState());
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////

  deletaFromDB({required String sectionID}) {
    database.rawDelete('DELETE FROM section WHERE sectionId = ?',
        ['$sectionID']).then((value) {
      isselected[sectionID] = false;
      getfromDataBase(database);
      print("item deleted successfully from database -----------------------");
      emit(DeletedatabaseState());
    }).catchError((error) {
      print(
          "error while deleting item from DB --------------------------------- ${error.toString()}");
    });
  }

////////////////////////////////////////////////////////////////////////////////////////////

  void inserttoDatabase({
    required String sectionTitle,
    required String sectionID,
  }) async {
    database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO section(sectionTitle, sectionId) VALUES("$sectionTitle", "$sectionID")')
          .then((value) {
        isselected[sectionID] = true;
        print("item addedd successfully from database -----------------------");

        emit(InsertdatabaseState());

        getfromDataBase(database);
        emit(GetdatabaseState());
      }).catchError((error) {
        print(
            "error while insert item to  DB --------------------------------- ${error.toString()}");
      });
      return null;
    });
  }
  //////////////////////////////////////////////////////////////////////////////////////////////

}
