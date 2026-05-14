import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/core/features/properties/data/bookmarked_repository.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
  return BookmarkRepository();
});

final savedPropertiesProvider =
    StateNotifierProvider.autoDispose<
      SavedPropertiesNotifier,
      AsyncValue<List<PropertyModel>>
    >((ref) {
      final repo = ref.watch(bookmarkRepositoryProvider);
      return SavedPropertiesNotifier(repo);
    });

class SavedPropertiesNotifier
    extends StateNotifier<AsyncValue<List<PropertyModel>>> {
  SavedPropertiesNotifier(this._repo) : super(const AsyncLoading()) {
    _load();
  }

  final BookmarkRepository _repo;

  Future<void> _load() async {
    try {
      if (!mounted) return;
      final items = _repo.getAllBookmarks();
      state = AsyncData(items);
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncError(e, st);   
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> save(PropertyModel property) async {
    state = const AsyncLoading();
    try {
      await _repo.saveBookmark(property);
      if (!mounted) return;
      final items = _repo.getAllBookmarks();
      state = AsyncData(items);
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncError(e, st);
    }
  }

  Future<void> remove(String propertyId) async {
    state = const AsyncLoading();
    try {
      await _repo.removeBookmark(propertyId);
      if (!mounted) return;
      final items = _repo.getAllBookmarks();
      state = AsyncData(items);
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncError(e, st);
    }
  }

  Future<void> toggle(PropertyModel property) async {
    state = const AsyncLoading();
    try {
      await _repo.toggleBookmark(property);
      if (!mounted) return;
      final items = _repo.getAllBookmarks();
      state = AsyncData(items);
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncError(e, st);
    }
  }

  bool isBookmarked(String propertyId) {
    return _repo.isBookmarked(propertyId);
  }
}
