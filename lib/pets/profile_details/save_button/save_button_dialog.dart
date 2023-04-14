import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/theme/custom_colors.dart';

enum LoadingState {
  uploadPictures,
  uploadDocuments,
  saveProfile,
}

class SaveButtonDialog extends StatefulWidget {
  const SaveButtonDialog({super.key});

  @override
  State<SaveButtonDialog> createState() => _SaveButtonDialogState();
}

class _SaveButtonDialogState extends State<SaveButtonDialog> {
  LoadingState _loadingState = LoadingState.saveProfile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _loadingState = LoadingState.saveProfile;
      });
      await Future.delayed(Duration(milliseconds: 1000));
      setState(() {
        _loadingState = LoadingState.uploadPictures;
      });
      await Future.delayed(Duration(milliseconds: 1000));
      setState(() {
        _loadingState = LoadingState.uploadDocuments;
      });
      await Future.delayed(Duration(milliseconds: 1000));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      elevation: 8,
      backgroundColor: Theme.of(context).primaryColor,
      child: getLoadingWidget(
        context,
        _loadingState,
      ),
    );
  }
}

Widget getLoadingWidget(BuildContext context, LoadingState loadingState) {
  switch (loadingState) {
    case LoadingState.saveProfile:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 28),
          Text(
            "Safe Profile",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 28),
          CircularProgressIndicator(
            color: getCustomColors(context).accent,
          ),
          const SizedBox(height: 28),
        ],
      );
    case LoadingState.uploadPictures:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 28),
          Text(
            "Uplaoding Pictures",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 28),
          CircularProgressIndicator(
            color: getCustomColors(context).accent,
          ),
          const SizedBox(height: 28),
        ],
      );
    case LoadingState.uploadDocuments:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 28),
          Text(
            "Uplaoding Documents",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 28),
          CircularProgressIndicator(
            color: getCustomColors(context).accent,
          ),
          const SizedBox(height: 28),
        ],
      );

    default:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      );
  }
}
