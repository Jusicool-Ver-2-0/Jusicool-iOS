import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

Future<CookieJar> cookieJar() async {
  final _dir = await getApplicationDocumentsDirectory();
  final CookieJar cookieJar = PersistCookieJar(
    storage: FileStorage('${_dir.path}.cookies/'),
  );
  return cookieJar;
}
