import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/src/bloc/abstract_bloc.dart';
import 'package:mychat/src/helper/flutter_local_storage.dart';
import 'package:rxdart/rxdart.dart';

class ServiceBloc implements AbstractBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _auth = BehaviorSubject<String>();

  final _firebaseAuth = FirebaseAuth.instance;
  final _flutterLocalStorage = FlutterLocalStorage();

  ServiceBloc() {
    _initAuth();
  }

  void _initAuth() async {
    if (await _flutterLocalStorage.getUserStorage().ready) {
      _auth.add(_flutterLocalStorage.getEmail() ?? '');
    }
  }

  @override
  Function(String) get onChangEmail => _email.sink.add;

  @override
  Function(String) get onChangePassword => _password.sink.add;

  @override
  Future<void> signInWithEmailAndPassword() async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: _email.value,
      password: _password.value,
    );

    if (result.user != null) {
      await _flutterLocalStorage.saveUserStorage(result.user.email);
      _auth.add(_email.value);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _flutterLocalStorage.clear();
    _auth.add('');
  }

  @override
  Stream<String> get onAuthStateChanged => _auth.stream;

  @override
  void dispose() {
    _email.close();
    _password.close();
    _auth.close();
  }
}
