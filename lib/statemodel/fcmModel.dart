import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tokenStateProvider =
StateNotifierProvider<FcmModelState, FcmModel>(
        (refs) => FcmModelState());


class FcmModel {
  FcmModel({required savedToken});
  String? savedToken;
}

class FcmModelState extends StateNotifier<FcmModel> {
  FcmModelState() : super(FcmModel(savedToken: ''));

  void myGetToken () {
    FirebaseMessaging.instance.getToken().then((token){
      assert(token != null);
      state = FcmModel(savedToken: token);
      print(token);
      // setState(() {
      //   _token = token!;
      //   exportedToken = token;
      //   print('-------------token: $token');
      // });
    });
  }


}