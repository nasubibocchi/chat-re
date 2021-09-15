import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final logOutProvider = StateNotifierProvider<LogOutModelState, LogOutModel>(
    (refs) => LogOutModelState());

class LogOutModel {
  LogOutModel({required userData});
}

class LogOutModelState extends StateNotifier<LogOutModel> {
  LogOutModelState() : super(LogOutModel(userData: null));

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await auth.signOut();
    state = LogOutModel(userData: null);
  }
}
