import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../logger/app_logger.dart';
import '../constants/app_routes.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      AppLogger.i('Initializing database...');

      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, AppConstants.databaseName);

      AppLogger.i('Database path: $path');

      return await openDatabase(
        path,
        version: AppConstants.databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e, stackTrace) {
      AppLogger.e('Failed to initialize database: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    AppLogger.i('Creating database tables...');

    // Detection records table
    await db.execute('''
      CREATE TABLE detection_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plantName TEXT NOT NULL,
        diseaseName TEXT NOT NULL,
        confidence REAL NOT NULL,
        imagePath TEXT NOT NULL,
        aiSuggestion TEXT,
        detectedAt INTEGER NOT NULL,
        isHealthy INTEGER NOT NULL
      )
    ''');

    // Create indexes for better performance
    await db.execute(
      'CREATE INDEX idx_detection_records_detected_at ON detection_records(detectedAt)',
    );
    await db.execute(
      'CREATE INDEX idx_detection_records_plant_name ON detection_records(plantName)',
    );
    await db.execute(
      'CREATE INDEX idx_detection_records_is_healthy ON detection_records(isHealthy)',
    );

    AppLogger.i('Database tables created successfully');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    AppLogger.i('Upgrading database from version $oldVersion to $newVersion');

    if (oldVersion < 2) {
      // Future migrations can be added here
      // Example: await db.execute('ALTER TABLE detection_records ADD COLUMN newColumn TEXT');
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
    AppLogger.i('Database closed');
  }
}
