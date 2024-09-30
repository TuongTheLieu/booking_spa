import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color.dart';
import '../../flutter_toast.dart';
import '../../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;

  // Đăng ký
  void register() {
    // Nếu thỏa mãn điều kiện nhập -> Lưu dữ liệu đăng ký vào bộ nhớ ứng dụng
    // Dữ liệu được lưu dưới dạng Key -> List<String>
    // Ví dụ: "0979224123" : ["0979224123", "Mật khẩu", "Họ tên"]
    // Key -> Phone
    // Index -> 0 => Phone, 1=>Password, 2=>FullName
    if (checkInput()) {
      _prefs.then(
        (SharedPreferences prefs) {
          prefs.setStringList(
            phoneController.text.trim(),
            <String>[
              phoneController.text.trim(),
              passwordController.text.trim(),
              fullNameController.text.trim(),
            ],
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
            // Chuyển dữ liệu phone + password sang màn Login
            arguments: {
              'phone': phoneController.text.trim(),
              'password': passwordController.text.trim(),
            },
          );
        },
      );
    }
  }
  // Kiểm tra dữ liệu nhập, trùng lặp sđt đăng ký
  bool checkInput() {
    if (fullNameController.text.trim().isEmpty) {
      toastInfo(msg: 'Họ tên không được để trống');
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      toastInfo(msg: 'Số điện thoại không được để trống');
      return false;
    }
    if (phoneController.text.trim().length != 10) {
      toastInfo(msg: 'Số điện thoại không hợp lệ');
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      toastInfo(msg: 'Mật khẩu không được để trống');
      return false;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      toastInfo(msg: 'Xác nhận mật khẩu không được để trống');
      return false;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      toastInfo(msg: 'Xác nhận mật khẩu không được để trống');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      toastInfo(msg: 'Mật khẩu không trùng khớp');
      return false;
    }
    // Kiểm tra sđt đã được đăng ký hay chưa
    bool duplicate = false;
    _prefs.then((SharedPreferences prefs) {
      duplicate = prefs.getStringList(phoneController.text) != null;
    });
    if (duplicate) {
      toastInfo(msg: 'Số điện thoại đã được đăng ký');
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 30),
                child: Center(
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5),
                child: Text('Họ và Tên'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.lock,
                        color: AppColor.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.background,
                    hintText: 'Nhập họ và tên',
                    suffixIcon: InkWell(
                      onTap: () {
                        fullNameController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                child: Text(
                  'Số điện thoại',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.person,
                        color: AppColor.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.background,
                    hintText: 'Nhập số điện thoại',
                    hintStyle: const TextStyle(),
                    suffixIcon: InkWell(
                      onTap: () {
                        phoneController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                child: Text('Mật khẩu'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.lock,
                        color: AppColor.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.background,
                    hintText: 'Nhập mật khẩu',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                child: Text('Nhập lại mật khẩu'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: !showConfirmPassword,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.lock,
                        color: AppColor.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.background,
                    hintText: 'Nhập lại mật khẩu',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      child: Icon(
                        showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: size.width * 0.6,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: const Center(
                      child: Text(
                        "Đăng kí",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bạn đã có tài khoản?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Đăng nhập',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
