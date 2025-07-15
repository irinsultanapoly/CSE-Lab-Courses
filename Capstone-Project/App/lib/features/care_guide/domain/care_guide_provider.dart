import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/care_guide_repository.dart';
import '../data/models/care_guide_models.dart';

final careGuideRepositoryProvider = Provider<CareGuideRepository>((ref) {
  return CareGuideRepository();
});

final careGuidesProvider = FutureProvider<CareGuidesData>((ref) async {
  final repository = ref.read(careGuideRepositoryProvider);
  return await repository.loadCareGuides();
});

final careGuideCategoriesProvider =
    Provider<AsyncValue<List<CareGuideCategory>>>((ref) {
      final careGuidesAsync = ref.watch(careGuidesProvider);
      return careGuidesAsync.when(
        data: (careGuidesData) => AsyncValue.data(careGuidesData.categories),
        loading: () => const AsyncValue.loading(),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );
    });

final selectedCategoryProvider = StateProvider<CareGuideCategory?>(
  (ref) => null,
);

final selectedGuideProvider = StateProvider<CareGuide?>((ref) => null);

final categoryByIdProvider = FutureProvider.family<CareGuideCategory?, String>((
  ref,
  categoryId,
) async {
  final repository = ref.read(careGuideRepositoryProvider);
  return await repository.getCategoryById(categoryId);
});

final guideByIdProvider =
    FutureProvider.family<CareGuide?, ({String categoryId, String guideId})>((
      ref,
      params,
    ) async {
      final repository = ref.read(careGuideRepositoryProvider);
      return await repository.getGuideById(params.categoryId, params.guideId);
    });
