// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class HelpScreen extends StatefulWidget {
//   @override
//   HelpScreenState createState() {
//     return HelpScreenState();
//   }
// }

// class HelpScreenState extends State<HelpScreen> {
//   // late WebViewController _controller;

//   // @override
//   final controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000))
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith('https://www.youtube.com/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse('https://flutter.dev'));

//   @override
//   void initState() {
//     super.initState();
//     // _controller = WebViewController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Help')),
//       // body: WebViewWidget(
//       // initialUrl: 'about:blank',
//       // onWebViewCreated: (WebViewController webViewController) {
//       //   _controller = webViewController;
//       //   _loadHtmlFromAssets();
//       // },
//       // controller: _controller,
//       // ),
//       body: WebViewWidget(
//         controller: controller,
//         // initialUrl: new Uri.dataFromString(snapshot.data, mimeType: 'text/html')
//         //     .toString(),
//         // javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }

//   // _loadHtmlFromAssets() async {
//   //   String fileText = await rootBundle.loadString('assets/help.html');
//   //   _controller.loadUrl(Uri.dataFromString(fileText,
//   //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//   //       .toString());
//   // }
// }
