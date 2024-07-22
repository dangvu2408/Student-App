import 'package:hust_sa/data/accessToHost.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Hàm để lưu giá trị vào SharedPreferences
Future<void> saveUser(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
}

// Hàm để lấy giá trị từ SharedPreferences
Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    return username;
}

Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? password = prefs.getString('password');
    return password;
}

Future<void> setFormHidden(String viewState, String eventValidation) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    await prefs1.setString('viewstate1', viewState);
    await prefs1.setString('eventvalidation1', eventValidation);
}

Future<String?> getViewState() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    final String? viewstate = prefs1.getString('viewstate1');
    return viewstate;
}

Future<String?> getEventValidation() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    final String? eventvalidation = prefs1.getString('eventvalidation1');
    return eventvalidation;
}