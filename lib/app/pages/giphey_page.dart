import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GiphyPage extends StatelessWidget {
  final Map giphyData;

  const GiphyPage(this.giphyData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(giphyData["title"]),
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  await Share.share(giphyData["images"]["fixed_height"]["url"]);
                })
          ],
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: Image.network(
          giphyData["images"]["fixed_height"]["url"],
        )));
  }
}
