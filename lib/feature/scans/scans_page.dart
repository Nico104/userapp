import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/scans/scans_list_item.dart';

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
        title: Text("ScansTitle".tr(namedArgs: {'name': widget.petName})),
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
                      ? ListView.builder(
                          itemCount: _scansList.length,
                          itemBuilder: (context, index) {
                            return ScanItem(
                              scan: _scansList.elementAt(index),
                            );
                          },
                        )
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
                                    .tr(namedArgs: {'name': widget.petName}),
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
