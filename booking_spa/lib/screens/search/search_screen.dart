import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../constants/color.dart';
import '../../constants/image.dart';
import '../../data/data.dart';
import '../../models/service_model.dart';
import '../../routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ServiceModel> services = Data.dataService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
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
                        onChanged: (input) {
                          setState(() {
                            services = Data.dataService
                                .where((service) =>
                                    (service.keySearch ?? '')
                                        .toLowerCase()
                                        .contains(input.toLowerCase()) ||
                                    (service.title ?? '')
                                        .toLowerCase()
                                        .contains(input.toLowerCase()))
                                .toList();
                          });
                        },
                        autofocus: true,
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
        body: SafeArea(
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.detail,
                          arguments: {
                            "service": services[index].toJson(),
                          },
                        );
                      },
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      services[index].image ?? '',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      services[index].title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      softWrap: false,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${NumberFormat('#,##0').format(services[index].price ?? 0)} đ',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      softWrap: false,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      services[index].sub ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: AppColor.grey,
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
