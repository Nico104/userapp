import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/general/utils_theme/store_manager.dart';
import 'package:userapp/general/widgets/future_error_widget.dart';
import 'package:userapp/general/widgets/loading_indicator.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

//TODO localization

void showChooseTimeZoneDialog(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return const ChooseTimeZone();
      }));
}

class ChooseTimeZone extends StatefulWidget {
  const ChooseTimeZone({Key? key}) : super(key: key);

  @override
  State<ChooseTimeZone> createState() => _ChooseTimeZoneState();
}

class _ChooseTimeZoneState extends State<ChooseTimeZone> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.5),
          child: SafeArea(
            child: FutureBuilder<dynamic>(
              future: StorageManager.readData('timezone'),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData || snapshot.data == null) {
                  print(snapshot.data);
                  return Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("12:11"),
                      ),
                      Expanded(
                        flex: 6,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: WheelChooser.custom(
                            onValueChanged: (s) {
                              EasyDebounce.debounce(
                                'timezone',
                                Duration(milliseconds: 200),
                                () {
                                  StorageManager.saveData("timezone", s);
                                  print("stored: " + s);
                                },
                              );
                            },
                            // datas: ["a", "b", "c"],
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data1"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data2"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data3"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data1"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data2"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data3"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data1"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data2"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("data3"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  // WidgetsBinding.instance
                  //     .addPostFrameCallback((_) => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const FutureErrorWidget(),
                  //           ),
                  //         ).then((value) => setState(
                  //               () {},
                  //             )));
                  //TODO error
                  return const SizedBox.shrink();
                } else {
                  //Loading
                  return const CustomLoadingIndicatior();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
