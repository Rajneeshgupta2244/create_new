import 'package:dummy/helper/constants.dart';
import 'package:dummy/screen/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_text.dart';
import '../../helper/common_text_style.dart';
import '../../helper/common_thing.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder:
          (controller) => Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CommonText(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflowEnabled: true,
                        style: CommonTextStyle.customTextStyle(
                          // color:
                          //     Theme.of(context).brightness == Brightness.dark
                          //         ? Colors.blue
                          //         : Colors.orange,
                          // fontSize: 10,
                          // fontWeight: FontWeight.w500,
                          // underline: false,
                        ),
                        text: "greeting",
                      ),
                      SizedBox(width: 40),
                      CommonText(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflowEnabled: true,
                        style: CommonTextStyle.customTextStyle(
                          // fontSize: 10,
                          // fontWeight: FontWeight.w500,
                          // underline: false,
                        ),
                        text: "hello",
                      ),

                      Spacer(),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'en') {
                            Get.updateLocale(
                              Locale('en', 'US'),
                            ); // Change to English
                          } else if (value == 'hi') {
                            Get.updateLocale(
                              Locale('hi', 'IN'),
                            ); // Change to Hindi
                          }
                        },
                        itemBuilder:
                            (BuildContext context) => [
                              PopupMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              PopupMenuItem(value: 'hi', child: Text('हिन्दी')),
                            ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
