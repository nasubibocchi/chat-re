import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/view/chatRoomListPage.dart';
import 'package:chat_re/view/loginPage.dart';
import 'package:chat_re/view/serchUserPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: 通知
    useEffect((){});
    return MyTab();
  }

}

class MyTab extends StatelessWidget {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  FirebaseAuth _auth = FirebaseAuth.instance;
  
  List<Widget> _buildScreens() {
    return [
      SerchUserPage(),
      StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ChatRoomListPage();
          } else {
            return LoginPage(index: 0);
          }
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_search),
        activeColorPrimary: kAccentColour,
        inactiveColorPrimary: kNuanceColour,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat_outlined),
        activeColorPrimary: kAccentColour,
        inactiveColorPrimary: kNuanceColour,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      // ignore: lines_longer_than_80_chars
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Default is true.
      // ignore: lines_longer_than_80_chars
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
      NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
