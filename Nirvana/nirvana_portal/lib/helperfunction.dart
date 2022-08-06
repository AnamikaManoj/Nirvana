import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String sharedPreferenceLoginInKey='ISLOGGEDIN';


  //saving data to sharedPreference

static Future<void> saveUserLoggedInState(bool isUserLoggedIn)async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  return await preferences.setBool(sharedPreferenceLoginInKey,isUserLoggedIn);
}


  //Getting Daa from SharedPreference
  static Future<bool> getUserLoggedInState()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceLoginInKey);}

}