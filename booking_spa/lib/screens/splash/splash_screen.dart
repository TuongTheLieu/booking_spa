import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color.dart';
import '../../constants/constant.dart';
import '../../constants/image.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    // Kiểm tra màn hình được vẽ xong thì thực hiện hàm phía trong
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOpened();
    });
  }

  // Kiểm tra khi ứng dụng đã được mở lần nào chưa.
  void getOpened() async {
    _prefs.then((SharedPreferences prefs) {
      isOpened = prefs.getBool(AppConstants.opened) ?? false;
    });
    // Dừng 2s
    Future.delayed(const Duration(milliseconds: 2000), () {
      // Nếu đã mở thì chuyển màn login -> Chưa mở thì chuyển màn Welcome
      if (isOpened) {
        Navigator.pushNamed(context, Routes.login);
      } else {
        Navigator.pushNamed(context, Routes.welcome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Image.asset(
          AppImage.logo,
          height: size * 0.18,
        ),
      ),
    );
  }
}
