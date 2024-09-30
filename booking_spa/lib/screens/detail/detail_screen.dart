import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/color.dart';
import '../../constants/constant.dart';
import '../../models/service_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ServiceModel serviceModel;

  @override
  void didChangeDependencies() {
    // Nhận dữ liệu từ màn hình Home chuyển qua
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    serviceModel = ServiceModel.fromJson(data['service']);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Thông tin chi tiết'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: serviceModel.title!,
                          child: Container(
                            width: 325,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(serviceModel.image!),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          serviceModel.title!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          serviceModel.sub!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColor.grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.primary,
                                  ),
                                ),
                                child: Text(
                                  '${NumberFormat("#,##0").format(serviceModel.price)} đ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                // Thực hiện cuộc gọi
                                onTap: () =>
                                    launchUrlString(AppConstants.contact),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.primary),
                                  child: const Text(
                                    'Đặt Hẹn Ngay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.background,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
