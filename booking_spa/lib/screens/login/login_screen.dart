import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/color.dart';
import '../../constants/constant.dart';
import '../../constants/image.dart';
import '../../data/global.dart';
import '../../flutter_toast.dart';
import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isShowPassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLoginInfo();
    });
  }

  // Khi ứng dụng được mở lại -> Kiểm tra trước đó user đã đăng xuất hay chưa
  // Nếu chưa thì tự động đăng nhập lại bằng số điện thoại đã lưu trước đó
  void getLoginInfo() {
    _prefs.then((SharedPreferences prefs) {
      bool isLogOut = prefs.getBool(AppConstants.isLogOut) ?? true;
      if (!isLogOut) {
        List<String> data;
        _prefs.then((SharedPreferences prefs) {
          String phone = prefs.getString(AppConstants.lastLogin) ?? '';
          data = prefs.getStringList(phone) ?? <String>[];
          login(data[0], data[1]);
        });
      }
    });
  }

  // Khi đăng nhập, đặt giá trị đã đăng xuất -> false
  // Lưu số điện thoại đã đăng nhập -> Phục vụ cho lần đăng nhập sau
  void setDataWhenLogin(String phone) {
    _prefs.then((SharedPreferences prefs) {
      prefs.setBool(AppConstants.isLogOut, false);
      prefs.setString(AppConstants.lastLogin, phone);
    });
  }

  void login(String phone, String password) {
    List<String> data;
    _prefs.then((SharedPreferences prefs) {
      // Kiểm tra tồn tại số điện thoại đã đăng ký hay chưa
      data = prefs.getStringList(phone) ?? <String>[];
      if (data.isNotEmpty) {
        // Kiểm tra mật khẩu có trùng khớp hay không
        if (data[1] == password) {
          // Lưu biến toàn cục khi thực hiện đăng nhập thành công
          GlobalData.fullName = data[2];
          GlobalData.phone = data[0];
          setDataWhenLogin(phone);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        } else {
          toastInfo(msg: 'Mật khẩu đăng nhập chưa đúng!');
        }
      } else {
        toastInfo(msg: 'Số điện thoại chưa được đăng ký!');
      }
    });
  }

  @override
  void didChangeDependencies() {
    // Kiểm tra nếu có dữ liệu từ các màn hình khác truyền tới
    // Gắn dữ liệu cho phone & password
    final arg = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (arg['phone'] != null) {
      phoneController.text = arg['phone'];
    }
    if (arg['password'] != null) {
      passwordController.text = arg['password'];
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Image.asset(
                  AppImage.logo,
                  height: 120,
                ),
              ),
              const Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 36),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.mail,
                        color: AppColor.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    hintText: 'Nhập số điện thoại',
                    hintStyle: const TextStyle(color: AppColor.grey),
                    suffixIcon: IconButton(
                        onPressed: () {
                          phoneController.clear();
                        },
                        icon: const Icon(Icons.clear)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.lock,
                        color: AppColor.grey,
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: Icon(
                        isShowPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.background,
                    hintText: 'Nhập mật khẩu',
                    hintStyle: const TextStyle(color: AppColor.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.6,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      login(
                        phoneController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                    child: const Text('Đăng nhập'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bạn chưa có tài khoản?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: const Text(
                        'Đăng ký',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
