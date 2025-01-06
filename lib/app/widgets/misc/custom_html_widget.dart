import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../file_viewer/image_viewer.dart';

class CustomHtmlWidget extends StatelessWidget {
  final String htmlString;
  final TextStyle? textStyle;

  const CustomHtmlWidget({super.key, required this.htmlString, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      htmlString,
      textStyle: textStyle,
      onTapImage: (imageData) {
        customImageViewNetwork(fileUrl: imageData.sources.last.url);
      },
      onTapUrl: (url) async {
        try {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

          return true;
        } catch (e) {
          debugPrint(e.toString());

          return false;
        }
      },
    );
  }
}
