import 'package:proyecto_tp3/repository/library_repo.dart';

class LibraryService {

  final _libraryRepo = LibraryRepo();  

  Future<void> addGame(int gameId) async {
    return await _libraryRepo.addGame(gameId);
  }

  Future<void> removeGame(int gameId) async {
    return await _libraryRepo.removeGame(gameId);
  }

  Future<List<int>?> library() async {
    return await _libraryRepo.library();
  }

  Future<bool> isGameInLibrary(int gameId) async {
    return await _libraryRepo.isGameInLibrary(gameId);
  }

}