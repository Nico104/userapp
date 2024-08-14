import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/feature/pets/profile_details/models/m_scan.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

class ScanItem extends StatefulWidget {
  const ScanItem({
    super.key,
    required this.scan,
  });

  final Scan scan;

  @override
  State<ScanItem> createState() => _ScanItemState();
}

class _ScanItemState extends State<ScanItem> {
  final radius = BorderRadius.circular(16);

  void _showOptions(BuildContext context) {
    showCustomNicoModalBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.network_wifi_3_bar_sharp),
            title: Text("scanPageShowIpAddress".tr()),
            onTap: () {
              Navigator.pop(context);
              showCustomNicoModalBottomSheet(
                context: context,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.network_wifi_3_bar_sharp),
                      title: Text(widget.scan.scanIpAddress),
                      trailing: IconButton(
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: sharingLink));
                          },
                          icon: Icon(Icons.copy_rounded)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
          ),
          // padding: const EdgeInsets.all(16),
          child: ListTile(
            onTap: () {
              _showOptions(context);
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              "${widget.scan.scanCity}, ${widget.scan.scanCountry}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            subtitle: Text(
              DateFormat('yyyy-MM-dd – kk:mm').format(widget.scan.scanDateTime),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: const Icon(Icons.arrow_forward),
          ),
          // child: IntrinsicHeight(
          //   child: Row(
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(widget.scan.scanCity),
          //           Text(widget.scan.scanCountry),
          //           Text(
          //             TimeOfDay.fromDateTime(widget.scan.scanDateTime)
          //                 .format(context),
          //           ),
          //         ],
          //       ),
          //       Spacer(),
          //       Column(
          //         children: [
          //           Spacer(),
          //           Text(
          //             TimeOfDay.fromDateTime(widget.scan.scanDateTime)
          //                 .toString(),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
