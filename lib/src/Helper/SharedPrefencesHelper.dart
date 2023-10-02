import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefencesHelper{

  static final  SharedPrefencesHelper _instance = SharedPrefencesHelper._internal();

  SharedPreferences? prefs ;
  factory SharedPrefencesHelper() {
    return _instance;
  }


  SharedPrefencesHelper._internal(){

    init();
  }
  init() async {
  prefs=  await SharedPreferences.getInstance();

  }

  setlogin() async {
  
    prefs!.setBool("login", true);
   }


     setToken(String token) async {
      prefs=  await SharedPreferences.getInstance();
      print("token"+token.toString());
    
      prefs!.setString("token", token.toString());

     }

     

}