import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/detection_history_repository.dart';
import '../data/models/detection_record.dart';

final detectionHistoryRepositoryProvider = Provider<DetectionHistoryRepository>(
  (ref) {
    return DetectionHistoryRepository();
  },
);

final detectionRecordsProvider = FutureProvider<List<DetectionRecord>>((
  ref,
) async {
  final repository = ref.read(detectionHistoryRepositoryProvider);
  return await repository.getAllDetectionRecords();
});

final detectionStatisticsProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  // Depend on the detection history notifier to refresh when records change
  ref.watch(detectionHistoryNotifierProvider);
  final repository = ref.read(detectionHistoryRepositoryProvider);
  return await repository.getStatistics();
});

final detectionRecordsByPlantProvider =
    FutureProvider.family<List<DetectionRecord>, String>((
      ref,
      plantName,
    ) async {
      final repository = ref.read(detectionHistoryRepositoryProvider);
      return await repository.getDetectionRecordsByPlant(plantName);
    });

final detectionRecordsByHealthProvider =
    FutureProvider.family<List<DetectionRecord>, bool>((ref, isHealthy) async {
      final repository = ref.read(detectionHistoryRepositoryProvider);
      return await repository.getDetectionRecordsByHealth(isHealthy);
    });

final detectionRecordByIdProvider =
    FutureProvider.family<DetectionRecord?, int>((ref, id) async {
      final repository = ref.read(detectionHistoryRepositoryProvider);
      return await repository.getDetectionRecordById(id);
    });

// Notifier for managing detection history state
class DetectionHistoryNotifier
    extends StateNotifier<AsyncValue<List<DetectionRecord>>> {
  final DetectionHistoryRepository _repository;

  DetectionHistoryNotifier(this._repository)
    : super(const AsyncValue.loading()) {
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    try {
      state = const AsyncValue.loading();
      final records = await _repository.getAllDetectionRecords();
      state = AsyncValue.data(records);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addDetectionRecord(DetectionRecord record) async {
    try {
      await _repository.insertDetectionRecord(record);
      await _loadRecords(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteDetectionRecord(int id) async {
    try {
      await _repository.deleteDetectionRecord(id);
      await _loadRecords(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteAllDetectionRecords() async {
    try {
      await _repository.deleteAllDetectionRecords();
      await _loadRecords(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadRecords();
  }
}

final detectionHistoryNotifierProvider =
    StateNotifierProvider<
      DetectionHistoryNotifier,
      AsyncValue<List<DetectionRecord>>
    >((ref) {
      final repository = ref.read(detectionHistoryRepositoryProvider);
      return DetectionHistoryNotifier(repository);
    });
