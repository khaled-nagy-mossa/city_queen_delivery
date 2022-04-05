import 'dart:developer';
import 'package:firebase_core/firebase_core.dart' as fbc;
// import 'package:firebase/firebase.dart' as fb;

abstract class FirebaseCoreHelper {
  const FirebaseCoreHelper();

  static Future<String> initial() async {
    try {
      // _initialFirebase();
      // final result = await _initializeWithOptionsObjectOfFBC();
      //
      // if (result != null && result.isNotEmpty) {
      /*        final res =*/ await _defaultInitializeOfFBC();
      //
      //   if (res != null && res.isNotEmpty) throw res;
      // }
      //
      return null;
    } catch (e) {
      log('Exception in FirebaseCoreHelper.initial : $e');
      return e.toString();
    }
  }

  // static common _name = 'Upsale';

  // static fbc.FirebaseOptions get _firebaseOptions {
  //   return common fbc.FirebaseOptions(
  //     apiKey: 'AIzaSyANuEFWCUFVybUrNM8gmKsGY3tQOqUkO88',
  //     authDomain: 'upsale-1751c.firebaseapp.com',
  //     projectId: 'upsale-1751c',
  //     storageBucket: 'upsale-1751c.appspot.com',
  //     messagingSenderId: '409998046026',
  //     appId: '1:409998046026:web:ff2b7062e8275c3df687b3',
  //     measurementId: 'G-ZJ99YH3T9H',
  //   );
  // }

  // static Future<String> _initializeWithOptionsObjectOfFBC() async {
  //   try {
  //     final app = await fbc.Firebase.initializeApp(
  //         name: _name, options: _firebaseOptions);
  //
  //     if (app == null) throw 'not initialized';
  //
  //     return null;
  //   } catch (e) {
  //     log('Exception in FirebaseCoreHelper.initializeWithOptionsObject : $e');
  //     return e.toString();
  //   }
  // }

  static Future<String> _defaultInitializeOfFBC() async {
    try {
      final app = await fbc.Firebase.initializeApp();

      if (app == null) throw 'not initialized';

      return null;
    } catch (e) {
      log('Exception in FirebaseCoreHelper.defaultInitialize : $e');
      return e.toString();
    }
  }

  // static void _initialFirebase() {
  //   final fb.App app = fb.initializeApp(
  //     apiKey: 'AIzaSyANuEFWCUFVybUrNM8gmKsGY3tQOqUkO88',
  //     authDomain: 'upsale-1751c.firebaseapp.com',
  //     projectId: 'upsale-1751c',
  //     storageBucket: 'upsale-1751c.appspot.com',
  //     messagingSenderId: '409998046026',
  //     appId: '1:409998046026:web:ff2b7062e8275c3df687b3',
  //     measurementId: 'G-ZJ99YH3T9H',
  //     // databaseURL: "YourDatabaseUrl",
  //   );
  // }
}
