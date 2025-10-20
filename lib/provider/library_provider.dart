import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/services/library_service.dart';

final libraryServiceProvider =
    Provider((ref) => LibraryService());