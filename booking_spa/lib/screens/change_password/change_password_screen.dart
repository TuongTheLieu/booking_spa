import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color.dart';
import '../../constants/constant.dart';
import '../../data/global.dart';
import '../../flutter_toast.dart';
import '../../routes.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showOldPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  void _logOut() {
    _prefs.then((SharedPreferences prefs) {
      prefs.setBool(AppConstants.isLogOut, true);
    });
  }

  // Đổi mật khẩu -> Cập nhật lại data trong ứng dụng với key là SĐT
  // -> Đăng xuất -> Truyền dữ liệu qua màn hình Login
  void changePass(String newPassword) {
    if (checkInput()) {
      _prefs.then(
        (SharedPreferences prefs) {
          prefs.setStringList(
            GlobalData.phone,
            <String>[
              GlobalData.phone,
              newPassword,
              GlobalData.fullName,
            ],
          );
          _logOut();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
            arguments: {
              'phone': GlobalData.phone,
              'password': newPassword,
            },
          );
        },
      );
    }
  }

  // Kiểm tra dữ liệu nhập
  bool checkInput() {
    if (oldPasswordController.text.trim().isEmpty) {
      toastInfo(msg: 'Mật khẩu cũ không được để trống');
      return false;
    }
    if (newPasswordController.text.trim().isEmpty) {
      toastInfo(msg: 'Mật khẩu mới không được để trống');
      return false;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      toastInfo(msg: 'Xác nhận mật khẩu không được để trống');
      return false;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      toastInfo(msg: 'Mật khẩu mới không trùng khớp');
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Đổi mật khẩu',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                child: Text(
                  'Mật khẩu cũ',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: oldPasswordController,
                  obscureText: !showOldPassword,
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
                    hintText: 'Nhập mật khẩu cũ',
                    hintStyle: const TextStyle(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showOldPassword = !showOldPassword;
                        });
                      },
                      child: Icon(
                        showOldPassword
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
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                child: Text('Mật khẩu mới'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  controller: newPasswordController,
                  obscureText: !showNewPassword,
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
                    hintText: 'Nhập mật khẩu mới',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showNewPassword = !showNewPassword;
                        });
                      },
                      child: Icon(
                        showNewPassword
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
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                child: Text('Nhập lại mật khẩu mới'),
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
                    hintText: 'Nhập lại mật khẩu mới',
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
                      changePass(newPasswordController.text.trim());
                    },
                    child: const Center(
                      child: Text(
                        "Đổi mật khẩu",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
