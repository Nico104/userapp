import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/scans/choose_timezone.dart';
import 'package:userapp/feature/scans/scans_list_item.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../pets/profile_details/models/m_scan.dart';
import '../pets/u_pets.dart';

class ScansPage extends StatefulWidget {
  const ScansPage({
    Key? key,
    required this.petName,
    required this.petProfileId,
  }) : super(key: key);

  final String petName;
  // final List<Scan> scans;

  final int petProfileId;

  @override
  State<ScansPage> createState() => _ScansPageState();
}

class _ScansPageState extends State<ScansPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late List<Scan> _scansList;
  late Future<void> _initScans;

  Future<void> _initScan() async {
    final List<Scan> scans = await getPetScans(widget.petProfileId);
    _scansList = scans;
  }

  Future<void> _refreshScanss() async {
    final List<Scan> scans = await getPetScans(widget.petProfileId);
    setState(() {
      _scansList = scans;
    });
  }

  @override
  void initState() {
    super.initState();
    _initScans = _initScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScansTitle".tr(namedArgs: {'Karamba': widget.petName})),
      ),
      // body: ListView.builder(
      //   itemCount: scans.length,
      //   itemBuilder: (context, index) {
      //     return ScanItem(
      //       scan: scans.elementAt(index),
      //     );
      //   },
      // ),
      body: FutureBuilder(
        future: _initScans,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return const Center(
                  child: Text('Loading...'),
                );
              }
            case ConnectionState.done:
              {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refreshScanss,
                  child: (_scansList.isNotEmpty)
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 42),
                              Text(
                                "scansPage_description_1".tr(),
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "scansPage_description_2".tr(),
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "scansPage_description_3".tr(),
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // InkWell(
                              //   onTap: () {
                              //     showChooseTimeZoneDialog(context);
                              //   },
                              //   child: Text("Time: +1"),
                              // ),
                              const SizedBox(height: 8),
                              const SizedBox(height: 42),
                              GroupedListView<Scan, DateTime>(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                elements: _scansList,
                                groupBy: (element) =>
                                    DateUtils.dateOnly(element.scanDateTime),
                                // groupSeparatorBuilder:
                                //     (DateTime groupByValue) => Text(
                                //   timeago.format(groupByValue),
                                // ),
                                groupSeparatorBuilder:
                                    (DateTime groupByValue) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    timeago.format(groupByValue),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                itemBuilder: (context, Scan element) =>
                                    ScanItem(
                                  scan: element,
                                ),
                                // itemBuilder: (c, element) {
                                //   return Card(
                                //     color: Colors.white,
                                //     elevation: 2,
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 10.0, vertical: 6.0),
                                //     child: SizedBox(
                                //       child: ListTile(
                                //         contentPadding:
                                //             const EdgeInsets.symmetric(
                                //                 horizontal: 20.0,
                                //                 vertical: 10.0),
                                //         leading:
                                //             const Icon(Icons.account_circle),
                                //         title: Text(
                                //           element.scanCity,
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .labelLarge,
                                //         ),
                                //         trailing:
                                //             const Icon(Icons.arrow_forward),
                                //       ),
                                //     ),
                                //   );
                                // },
                                itemComparator: (item1, item2) => item1
                                    .scanDateTime
                                    .compareTo(item2.scanDateTime), // optional
                                // useStickyGroupSeparators: true, // optional
                                floatingHeader: true, // optional
                                order: GroupedListOrder
                                    .DESC, // optional// optional
                              ),
                            ],
                          ),
                        )
                      // ? ListView.builder(
                      //     itemCount: _scansList.length,
                      //     itemBuilder: (context, index) {
                      //       return ScanItem(
                      //         scan: _scansList.elementAt(index),
                      //       );
                      //     },
                      //   )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 30.w,
                                child: Image.asset("assets/tmp/scans2.png"),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                "noScans"
                                    .tr(namedArgs: {'Karamba': widget.petName}),
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            ],
                          ),
                        ),
                );
              }
          }
        },
      ),
    );
  }
}

// _createGroupedListView() {
//   return GroupedListView<dynamic, String>(
//     elements: _elements,
//     groupBy: (element) => element['group'],
//     groupComparator: (value1, value2) => value2.compareTo(value1),
//     itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
//     order: GroupedListOrder.DESC,
//     useStickyGroupSeparators: true,
//     groupSeparatorBuilder: (String value) => Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         value,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     ),
//     itemBuilder: (c, element) {
//       return Card(
//         elevation: 8.0,
//         margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//         child: SizedBox(
//           child: ListTile(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             leading: const Icon(Icons.account_circle),
//             title: Text(element['name']),
//             trailing: const Icon(Icons.arrow_forward),
//           ),
//         ),
//       );
//     },
//   );
// }
