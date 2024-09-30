import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/color.dart';
import '../../constants/image.dart';
import '../../data/data.dart';
import '../../data/global.dart';
import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controllerSlider = PageController();
  int typeService = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (controllerSlider.page == null) return;
      if (controllerSlider.page == 2) {
        controllerSlider.animateToPage(
          0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeIn,
        );
      } else {
        controllerSlider.nextPage(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controllerSlider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: Container(
          margin: const EdgeInsets.only(left: 7, right: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
                height: 12,
                child: Image.asset(AppImage.menu),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.profile);
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(AppImage.user),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: CustomScrollView(
          slivers: [
            // Welcome
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: const Text(
                  'Xin Chào!',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Thông tin người dùng
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  GlobalData.fullName,
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Tìm kiếm
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                    width: 325,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColor.grey),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 17),
                          width: 16,
                          height: 16,
                          child: Image.asset(AppImage.search),
                        ),
                        SizedBox(
                          width: 240,
                          height: 40,
                          child: TextField(
                            canRequestFocus: false,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.search,
                              );
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                              hintStyle: TextStyle(
                                color: AppColor.grey,
                              ),
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Quảng cáo, panel
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 325,
                    height: 160,
                    child: PageView(
                      controller: controllerSlider,
                      children: [
                        Container(
                          width: 325,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                AppImage.home1,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 325,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                AppImage.home2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 325,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                AppImage.home3,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SmoothPageIndicator(
                    controller: controllerSlider,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColor.primary,
                      dotColor: AppColor.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              typeService = 0;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: typeService == 0
                                  ? AppColor.lightPrimary
                                  : AppColor.background,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: AppColor.lightPrimary,
                              ),
                            ),
                            child: const Text('Tất cả'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              typeService = 1;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: typeService == 1
                                  ? AppColor.lightPrimary
                                  : AppColor.background,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: AppColor.lightPrimary,
                              ),
                            ),
                            child: const Text('Phổ biến'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              typeService = 2;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: typeService == 2
                                  ? AppColor.lightPrimary
                                  : AppColor.background,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: AppColor.lightPrimary,
                              ),
                            ),
                            child: const Text('Mới nhất'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.6,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: Data.dataService.length,
                  (context, index) {
                    if (typeService == 0) {
                      Data.dataService
                          .sort((a, b) => a.title!.compareTo(b.title!));
                    }
                    if (typeService == 1) {
                      Data.dataService
                          .sort((a, b) => a.price!.compareTo(b.price!));
                    }
                    if (typeService == 2) {
                      Data.dataService.sort((a, b) => a.sub!.compareTo(b.sub!));
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          Routes.detail,
                          // Truyền dữ liệu sang màn hình chi tiết
                          arguments: {
                            "service": Data.dataService[index].toJson(),
                          },
                        );
                      },
                      child: Hero(
                        tag: Data.dataService[index].title ?? '',
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    Data.dataService[index].image ?? '',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Data.dataService[index].title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: AppColor.background,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${NumberFormat('#,##0').format(Data.dataService[index].price ?? 0)} đ',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: AppColor.background,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
