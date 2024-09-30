import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/color.dart';
import '../../constants/constant.dart';
import '../../data/data.dart';
import '../../routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Khi ứng dụng mở lần đầu tiên -> không mở màn welcome cho lần sau
  void _setOpened() {
    _prefs.then((SharedPreferences prefs) {
      prefs.setBool(AppConstants.opened, true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.75,
              child: PageView.builder(
                controller: _controller,
                itemCount:  Data.dataWelcome.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: height * 0.55,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            Data.dataWelcome[index]["image"]!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Text(
                                 Data.dataWelcome[index]["title"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                 Data.dataWelcome[index]["sub"]!,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
              controller: _controller,
              count:  Data.dataWelcome.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xffBE2EC3),
                dotColor: AppColor.grey,
                dotHeight: 13,
                dotWidth: 13,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FittedBox(
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Nếu là trang cuối cùng thì thực hiện chuyển màn -> Login
                    // Nếu chưa phải trang cuối thì chuyển trang tiếp theo
                    if (currentPage ==  Data.dataWelcome.length - 1) {
                      _setOpened();
                      Navigator.pushNamed(context, Routes.login);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: currentPage ==  Data.dataWelcome.length - 1
                      ? const Text('Bắt đầu')
                      : const Text('Tiếp theo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
