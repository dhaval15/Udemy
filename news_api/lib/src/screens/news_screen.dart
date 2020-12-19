import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../view_models/news_item_view_model.dart';

class NewsScreen extends StatelessWidget {
  final NewsItemViewModel model;

  const NewsScreen({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: model.url,
        ),
      ),
    );
  }
}
