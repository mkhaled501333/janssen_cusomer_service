import 'package:janssen_cusomer_service/Ui/users/data/api.dart';
import 'package:janssen_cusomer_service/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends UsersApi {
  final SharedPreferences _sharedPrefs;
  AuthProvider(this._sharedPrefs);

  bool get isLoggedIn => _sharedPrefs.getString('email') != null;
  String? get nameLoged => _sharedPrefs.getString('name');

  void login(String email, String password) {
    getuser(email, password).then((onValue) => _setTOPrefs(onValue));
  }

  _setTOPrefs(UserModel? onValue) {
    if (onValue != null) {
      _sharedPrefs.setString('email', onValue.email);
      _sharedPrefs.setString('password', onValue.password);
      _sharedPrefs.setString('name', onValue.name);
      notifyListeners();
    }
  }

  void logout() {
    _sharedPrefs.remove('email');
    _sharedPrefs.remove('password');
    _sharedPrefs.remove('name');
    notifyListeners();
  }

  UserModel? selectedUser;
}
