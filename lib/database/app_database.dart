import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDataBase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, "bytebank.db");
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSQL);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
