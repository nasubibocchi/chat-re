import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginStateProvider =
    StateNotifierProvider<LoginStateModelState, LoginStateModel>(
        (refs) => LoginStateModelState());

class LoginStateModel {
  LoginStateModel({required bool this.isLoginLoading});

  bool? isLoginLoading;
}

class LoginStateModelState extends StateNotifier<LoginStateModel> {
  LoginStateModelState() : super(LoginStateModel(isLoginLoading: false));

  void startLoading() {
    state = LoginStateModel(isLoginLoading: true);
  }

  void endLoading() {
    state = LoginStateModel(isLoginLoading: false);
  }
}
