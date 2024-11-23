import 'package:asmaul_husna/model/model_bookmark.dart';
import 'package:hive/hive.dart';

class BookmarkDbHelper {
  static const String _boxName = 'bookmarkBox';

  static final BookmarkDbHelper _instance = BookmarkDbHelper._internal();

  factory BookmarkDbHelper() => _instance;

  BookmarkDbHelper._internal();

  // Membuka atau membuat box Hive
  Future<Box<ModelBookmark>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<ModelBookmark>(_boxName);
    }
    return Hive.box<ModelBookmark>(_boxName);
  }

  // Menyimpan bookmark
  Future<int> saveData(ModelBookmark modelBookmark) async {
    try {
      final box = await _getBox();
      final key = modelBookmark.number ??
          DateTime.now().millisecondsSinceEpoch.toString();
      await box.put(key, modelBookmark);
      return 1;
    } catch (e) {
      print('Error saving bookmark: $e');
      return 0;
    }
  }

  // Mendapatkan semua data bookmark
  Future<List<ModelBookmark>> getAllBookmarks() async {
    final box = await _getBox();
    return box.values.toList();
  }

  // Menghapus bookmark berdasarkan Number
  Future<void> deleteBookmarkByNumber(int number) async {
    final box = await _getBox();

    try {
      final bookmarkToDelete = box.values.firstWhere(
            (bookmark) => bookmark.number == number,
      );

      await box.delete(bookmarkToDelete.number);
      print('Bookmark dengan number $number telah dihapus.');
    } catch (e) {
      print('Bookmark dengan number $number tidak ditemukan.');
    }

    getAllBookmarks();
  }

  // Mengecek apakah bookmark dengan nomor tertentu memiliki flag
  Future<bool> isFlagged(int number) async {
    final box = await _getBox();
    final bookmark = box.values.cast<ModelBookmark?>().firstWhere(
          (bookmark) => bookmark?.number == number,
          orElse: () => null,
        );
    return bookmark?.flag == 'Y';
  }
}
