import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'notebook.db');

    return await openDatabase(
      path,
      version: 2,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await _createTables(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE notes ADD COLUMN is_deleted INTEGER DEFAULT 0',
          );
        }
      },
    );
  }

  static Future<void> _createTables(Database db) async {

    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // // 📂 جدول التصنيفات
    // await db.execute('''
    //   CREATE TABLE categories(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     title TEXT NOT NULL,
    //     user_id INTEGER NOT NULL,
    //     FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    //   )
    // ''');


    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        created_at TEXT,
        updated_at TEXT,
        pdfPath TEXT
        is_favorite INTEGER DEFAULT 0,
        is_deleted INTEGER DEFAULT 0, -- 🗑 سلة المحذوفات
        user_id INTEGER NOT NULL,
        category_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE note_images(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note_id INTEGER NOT NULL,
        image_path TEXT NOT NULL,
        FOREIGN KEY (note_id) REFERENCES notes(id) ON DELETE CASCADE
      )
    ''');
  }


  // ============================================
  static Future<void> deleteUserCompletely(int userId) async {
    final db = await database;


    await db.delete('notes', where: 'user_id = ?', whereArgs: [userId]);


    await db.delete('categories', where: 'user_id = ?', whereArgs: [userId]);


    await db.delete('users', where: 'id = ?', whereArgs: [userId]);
  }
}
