import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/models.dart';

class ContentList extends StatelessWidget {
  final String title;
  final bool originals;
  final List<Content> contentList;

  const ContentList(
      {Key key, this.originals = false, this.contentList, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: originals ? 500 : 220,
            child: ListView.builder(
              itemCount: contentList.length,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final content = contentList[index];
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    height: originals ? 400 : 200,
                    width: originals ? 200 : 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(content.imageUrl),
                      fit: BoxFit.cover,
                    )),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
