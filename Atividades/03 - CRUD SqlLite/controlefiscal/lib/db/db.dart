import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{
   late Database db;

   Future open() async {
        // Get a location using getDatabasesPath
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'controleFiscal.db');
        //join is from path package
        print(path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

        db = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
             // When creating the db, create the table
              await db.execute('''

                    CREATE TABLE IF NOT EXISTS controleFiscal( 
                          id primary key,
                          categoria varchar(255) not null,
                          valor real not null,
                          descricao varchar(255) not null
                      );

                      //create more table here
                  
                  ''');
            //table controleFiscal will be created if there is no table 'controleFiscal'
            print("Table Created");
        });
   }

  Future<Map<dynamic, dynamic>?> getControleFiscal(double valor) async {
    List<Map> maps = await db.query('controleFiscal',
        where: 'valor = ?',
        whereArgs: [valor]);
    //getting student data with roll no.
    if (maps.isNotEmpty) {
       return maps.first;
    }
    return null;
  }
}