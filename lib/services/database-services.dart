import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {

  Database movieDatabase;
  
  Future<bool> initiateDatabase(String databaseName) async {
    String databaseDirectory = await getDatabasesPath();
    String databasePath = join(databaseDirectory, databaseName+".db");
    movieDatabase = await openDatabase(databasePath);
    showDatabasePath();
    return movieDatabase.isOpen;
  }

  showDatabasePath() {
    print("## Database Path -");
    print(movieDatabase.path);
  }

  Future<bool> initialiseTables() async {
    await movieDatabase.execute("CREATE TABLE MOVIES(userId TEXT, movieId INTEGER, movieTitle TEXT, directorName TEXT, posterPath TEXT, rating INTEGER, genre TEXT, UNIQUE(userId, movieId))");
    return true;
  }

  Future<int> insertObjectToTable(String tableName, Map<String, dynamic> values) async {
    var result = await movieDatabase.insert(tableName, values);
    return result;
  }

  Future<List> fetchAllRecordsFromDatabase(String tableName, Map<String, dynamic> identifier) async {
    String whereClause = "";
    if(identifier.length > 0) {
      whereClause += " WHERE";
      identifier.forEach((key, value) {
        String seperator = "";
        if(value.runtimeType == String) seperator = "'";
        whereClause += " $key = "+seperator+"$value"+seperator+" AND";
      });
      whereClause = whereClause.substring(0, whereClause.length-3);
    }
    var result = await movieDatabase.rawQuery("SELECT * FROM MOVIES"+whereClause);
    return result;
  }

  Future<int> removeRecordFromDatabase(String tableName, Map<String, dynamic> identifier) {
    String whereClause = "";
    if(identifier.length > 0) {
      whereClause += " WHERE";
      identifier.forEach((key, value) {
        String seperator = "";
        if(value.runtimeType == String) seperator = "'";
        whereClause += " $key = "+seperator+"$value"+seperator+" AND";
      });
      whereClause = whereClause.substring(0, whereClause.length-3);
    }
    var result = movieDatabase.rawDelete("DELETE FROM $tableName"+whereClause);
    return result;
  }

  Future updateRecordInTable(String tableName, Map<String, dynamic> values, Map<String, dynamic> identifier) async {
    String setClause = "";
    String whereClause = " ";
    if(values.length > 0) {
      setClause += " SET";
      values.forEach((key, value) {
        if(!identifier.containsKey(key) && value != null) {
          String seperator = "";
          if(value.runtimeType == String) seperator = "'";
          setClause += " $key = "+seperator+"$value"+seperator+",";
        }
      });
      setClause = setClause.substring(0, setClause.length-1);
    }
    if(identifier.length > 0) {
      whereClause += " WHERE ";
      identifier.forEach((key, value) {
        String seperator = "";
        if(value.runtimeType == String) seperator = "'";
        whereClause += " $key = "+seperator+"$value"+seperator+" AND";
      });
      whereClause = whereClause.substring(0, whereClause.length-3);
    }
    var result = await movieDatabase.rawUpdate("UPDATE $tableName"+setClause+whereClause);
    // await movieDatabase.update(tableName, values, where: "movieTitle", whereArgs: [values["movieTitle"]]);
    return result;
  }

}