class StorageService {
  static final StorageService _singleton = StorageService._internal();

  StorageService._internal() {
    //constructor
  }

  factory StorageService() {
    return _singleton;
  }
}
