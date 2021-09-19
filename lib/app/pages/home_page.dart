import 'package:app_giphy/app/pages/giphey_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String _search;
  int _offset = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
              "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: "Pesquise aqui"),
                    textAlign: TextAlign.center,
                    onSubmitted: (text) {
                      setState(() {
                        _offset = 0;
                        _search = text;
                      });
                    },
                  ),
                ),
                FutureBuilder(
                    future: _getGiphies(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            height: 300.0,
                            width: 200.0,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        default:
                          if (snapshot.hasError)
                            return Center(
                              child: ElevatedButton(
                                child: Text("Erro, tente novamente"),
                                onPressed: () {},
                              ),
                            );
                          return _createTableGift(context, snapshot);
                      }
                    }),
              ],
            ),
          ),
        ));
  }

  Future<Map> _getGiphies() async {
    Dio dio = Dio();
    var response;
    // const urlTreding =
    //     "https://api.giphy.com/v1/gifs/trending?api_key=RL3beyGXNxL3nKfhYYrDnkQmbpUufVQY&limit=25&rating=pg";
    final urlSearch =
        "https://api.giphy.com/v1/gifs/search?api_key=RL3beyGXNxL3nKfhYYrDnkQmbpUufVQY&q=$_search&limit=20&offset=$_offset&rating=g&lang=pt";
    try {
      response = await dio.get(urlSearch);
    } catch (e) {
      throw Exception("Falha ao carregar a API");
    }
    return response.data;
  }

  Widget _createTableGift(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 3.0, mainAxisSpacing: 3.0),
            itemCount: snapshot.data["data"].length,
            itemBuilder: (context, index) {
              if (index == 19)
                return GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 60.0),
                      Text("Carregar mais...")
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      this._offset += 19;
                    });
                  },
                );
              return GestureDetector(
                child: Image.network(
                  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                  height: 300.0,
                  width: 300.0,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          GiphyPage(snapshot.data["data"][index]),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
