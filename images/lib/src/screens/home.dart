import 'package:flutter/material.dart';
import '../models/image_model.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  List<ImageModel> images = [];

  void addImage() async {
    count++;
    final response =
        await get('https://jsonplaceholder.typicode.com/photos/$count');
    final parsedJson = json.decode(response.body);
    setState(() {
      images.add(ImageModel.fromJson(parsedJson));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images!'),
      ),
      body: buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: addImage,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildList() => ListView.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          final image = images[index];
          return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(20),
            key: Key(image.id.toString()),
            child: Column(
              children: [
                Image.network(image.url),
                SizedBox(height: 8),
                Text(image.title),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
          );
        },
      );
}
