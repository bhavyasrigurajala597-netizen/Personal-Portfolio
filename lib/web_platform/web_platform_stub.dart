final Map<String, String> _memoryStorage = {};

String? loadFromStorage(String key) => _memoryStorage[key];

void saveToStorage(String key, String value) {
  _memoryStorage[key] = value;
}

void openExternalUrl(Uri uri) {
  // No-op for non-web environments (such as unit/widget tests)
}
