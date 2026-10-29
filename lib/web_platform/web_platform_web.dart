import 'package:web/web.dart' as web;

String? loadFromStorage(String key) {
  try {
    return web.window.localStorage.getItem(key);
  } catch (_) {
    return null;
  }
}

void saveToStorage(String key, String value) {
  try {
    web.window.localStorage.setItem(key, value);
  } catch (_) {
    // Ignore storage quota or disabled storage errors
  }
}

void openExternalUrl(Uri uri) {
  final anchor = web.HTMLAnchorElement()
    ..href = uri.toString()
    ..target = '_blank'
    ..rel = 'noopener noreferrer';
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
