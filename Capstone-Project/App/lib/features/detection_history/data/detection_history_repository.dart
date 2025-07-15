import 'package:sqflite/sqflite.dart';
import '../../../core/database/database_service.dart';
import '../../../core/logger/app_logger.dart';
import 'models/detection_record.dart';

class DetectionHistoryRepository {
  final DatabaseService _databaseService = DatabaseService();

  // Insert a new detection record
  Future<int> insertDetectionRecord(DetectionRecord record) async {
    try {
      AppLogger.i('Inserting detection record for ${record.plantName}');

      final db = await _databaseService.database;
      final id = await db.insert(
        'detection_records',
        record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      AppLogger.i('Detection record inserted with ID: $id');
      return id;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to insert detection record: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get all detection records ordered by date (newest first)
  Future<List<DetectionRecord>> getAllDetectionRecords() async {
    try {
      AppLogger.i('Fetching all detection records');

      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'detection_records',
        orderBy: 'detectedAt DESC',
      );

      final records = List.generate(
        maps.length,
        (i) => DetectionRecord.fromMap(maps[i]),
      );
      AppLogger.i('Fetched ${records.length} detection records');

      return records;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch detection records: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get detection records by plant name
  Future<List<DetectionRecord>> getDetectionRecordsByPlant(
    String plantName,
  ) async {
    try {
      AppLogger.i('Fetching detection records for plant: $plantName');

      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'detection_records',
        where: 'plantName = ?',
        whereArgs: [plantName],
        orderBy: 'detectedAt DESC',
      );

      final records = List.generate(
        maps.length,
        (i) => DetectionRecord.fromMap(maps[i]),
      );
      AppLogger.i('Fetched ${records.length} detection records for $plantName');

      return records;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch detection records for plant $plantName: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get detection records by health status
  Future<List<DetectionRecord>> getDetectionRecordsByHealth(
    bool isHealthy,
  ) async {
    try {
      AppLogger.i(
        'Fetching detection records for health status: ${isHealthy ? "healthy" : "diseased"}',
      );

      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'detection_records',
        where: 'isHealthy = ?',
        whereArgs: [isHealthy ? 1 : 0],
        orderBy: 'detectedAt DESC',
      );

      final records = List.generate(
        maps.length,
        (i) => DetectionRecord.fromMap(maps[i]),
      );
      AppLogger.i(
        'Fetched ${records.length} detection records for health status: ${isHealthy ? "healthy" : "diseased"}',
      );

      return records;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch detection records by health status: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get detection records within a date range
  Future<List<DetectionRecord>> getDetectionRecordsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      AppLogger.i(
        'Fetching detection records from ${startDate.toIso8601String()} to ${endDate.toIso8601String()}',
      );

      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'detection_records',
        where: 'detectedAt BETWEEN ? AND ?',
        whereArgs: [
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        ],
        orderBy: 'detectedAt DESC',
      );

      final records = List.generate(
        maps.length,
        (i) => DetectionRecord.fromMap(maps[i]),
      );
      AppLogger.i('Fetched ${records.length} detection records in date range');

      return records;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch detection records by date range: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get a single detection record by ID
  Future<DetectionRecord?> getDetectionRecordById(int id) async {
    try {
      AppLogger.i('Fetching detection record with ID: $id');

      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'detection_records',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) {
        AppLogger.i('No detection record found with ID: $id');
        return null;
      }

      final record = DetectionRecord.fromMap(maps.first);
      AppLogger.i('Fetched detection record with ID: $id');

      return record;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch detection record with ID $id: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Update a detection record
  Future<int> updateDetectionRecord(DetectionRecord record) async {
    try {
      AppLogger.i('Updating detection record with ID: ${record.id}');

      final db = await _databaseService.database;
      final count = await db.update(
        'detection_records',
        record.toMap(),
        where: 'id = ?',
        whereArgs: [record.id],
      );

      AppLogger.i('Updated $count detection record(s)');
      return count;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to update detection record: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Delete a detection record
  Future<int> deleteDetectionRecord(int id) async {
    try {
      AppLogger.i('Deleting detection record with ID: $id');

      final db = await _databaseService.database;
      final count = await db.delete(
        'detection_records',
        where: 'id = ?',
        whereArgs: [id],
      );

      AppLogger.i('Deleted $count detection record(s)');
      return count;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to delete detection record with ID $id: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Delete all detection records
  Future<int> deleteAllDetectionRecords() async {
    try {
      AppLogger.i('Deleting all detection records');

      final db = await _databaseService.database;
      final count = await db.delete('detection_records');

      AppLogger.i('Deleted $count detection record(s)');
      return count;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to delete all detection records: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      AppLogger.i('Fetching detection statistics');

      final db = await _databaseService.database;

      // Total records
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM detection_records',
      );
      final totalRecords = totalResult.first['count'] as int;

      // Healthy records
      final healthyResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM detection_records WHERE isHealthy = 1',
      );
      final healthyRecords = healthyResult.first['count'] as int;

      // Diseased records
      final diseasedRecords = totalRecords - healthyRecords;

      // Most common plants
      final plantsResult = await db.rawQuery('''
        SELECT plantName, COUNT(*) as count 
        FROM detection_records 
        GROUP BY plantName 
        ORDER BY count DESC 
        LIMIT 5
      ''');

      // Most common diseases
      final diseasesResult = await db.rawQuery('''
        SELECT diseaseName, COUNT(*) as count 
        FROM detection_records 
        WHERE isHealthy = 0 
        GROUP BY diseaseName 
        ORDER BY count DESC 
        LIMIT 5
      ''');

      final statistics = {
        'totalRecords': totalRecords,
        'healthyRecords': healthyRecords,
        'diseasedRecords': diseasedRecords,
        'topPlants': plantsResult,
        'topDiseases': diseasesResult,
      };

      AppLogger.i('Fetched detection statistics: $statistics');
      AppLogger.i('Total records: $totalRecords, Healthy: $healthyRecords, Diseased: $diseasedRecords');
      return statistics;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to fetch detection statistics: $e');
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
