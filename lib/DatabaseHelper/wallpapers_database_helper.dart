import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/Api/favorite_wallpaper.dart';

class WallpapersDatabaseHelper {
  static const String tableName = 'favorite_wallpapers';

  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'wallpapers_database.db');
    return openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        photoUrl TEXT
      )
    ''');
  }

  Future<void> insertWallpaperToFavorite(
      FavoriteWallpaper wallpaper) async {
    final db = await _initializeDatabase();
    await db.insert(tableName, wallpaper.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await db.close();
  }

  Future<void> removeWallpaperToFavorite(int id) async {
    final db = await _initializeDatabase();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    await db.close();
  }

  Future<List<FavoriteWallpaper>> getAllFavoriteWallpapers() async {
    final db = await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    await db.close();
    return maps.map((map) => FavoriteWallpaper.fromMap(map)).toList();
  }
}
