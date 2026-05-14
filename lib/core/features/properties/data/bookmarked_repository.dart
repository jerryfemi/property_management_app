
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';

class BookmarkRepository {
  static const String _boxName = 'bookmarks';

  Box<PropertyModel> get _bookmarkedBox => Hive.box<PropertyModel>(_boxName);



  // is bookmarked?
  bool isBookmarked(String propertyId) =>
      _bookmarkedBox.containsKey(propertyId);

  Future<void> saveBookmark(PropertyModel property) async {
    await _bookmarkedBox.put(property.id, property);
  }

  Future<void> removeBookmark(String propertyId) async {
    await _bookmarkedBox.delete(propertyId);
  }

  Future<void> toggleBookmark(PropertyModel property) async {
    if (isBookmarked(property.id)) {
      await removeBookmark(property.id);
      return;
    }

    await saveBookmark(property);
  }

  List<PropertyModel> getAllBookmarks() => _bookmarkedBox.values.toList();
}

