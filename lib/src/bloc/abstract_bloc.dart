abstract class AbstractBloc {
  Function(String) get onChangEmail;
  Function(String) get onChangePassword;

  Stream<String> get onAuthStateChanged;

  Future<void> signInWithEmailAndPassword();
  Future<void> signOut();

  void dispose();
}
