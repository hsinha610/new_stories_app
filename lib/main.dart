import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppHome(),
      debugShowCheckedModeBanner: true,
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  /* static String url1 =
      "https://newsapi.org/v2/sources?language=$language&apiKey=$apiKey";

  static String headlines_url =
      "https://newsapi.org/v2/top-headlines?language=$language&country=$country&category=$category&pageSize=$pageSize&apiKey=$apiKey";

  static String apiKey = "YOUR_API_KEY_HERE";
  static String language = "en";
  static String country = "in";
  static String category = "technology";
  static int pageSize = 25;
  Map<String, dynamic> data;
  http.Response response;

  Future<dynamic> getData() async {
    response = await http.get(headlines_url);
    data = await jsonDecode(response.body);

    return data;
  }
*/
  bool webPageLoading = true;
  @override
  Widget build(BuildContext context) {
    String dropDownValue = "in";

    String apiKey = "YOUR_API_KEY_HERE"; //Enter your API Here
    String language = "en";//Enter your Language here
    String country = "in";
    String category = "science";
    int pageSize = 25;
    String url1 =
        "https://newsapi.org/v2/sources?language=$language&apiKey=$apiKey";

    String headlines_url =
        "https://newsapi.org/v2/top-headlines?language=$language&country=$country&category=$category&pageSize=$pageSize&apiKey=$apiKey";

    Map<String, dynamic> data;
    http.Response response;

    Future<dynamic> getData() async {
      response = await http.get(headlines_url);
      data = await jsonDecode(response.body);

      return data;
    }

    return SafeArea(
      right: false,
      left: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Tech News App"),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return Center(
                  child: ListView.builder(
                    itemCount: snap.data['articles'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent[100],
                          border: Border(
                            left:
                                BorderSide(color: Colors.blueAccent, width: 10),
                            bottom:
                                BorderSide(color: Colors.blueAccent, width: 0),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            snap.data['articles'][index]['title'],
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          onTap: () {
                            showDialog(
                              context: context,
                              child: Dialog(
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: WebView(
                                    gestureNavigationEnabled: true,
                                    onPageFinished: (a) {
                                      setState(() {
                                        webPageLoading = false;
                                      });
                                    },
                                    onPageStarted: (a) {
                                      setState(() {
                                        webPageLoading = true;
                                      });
                                    },
                                    initialMediaPlaybackPolicy:
                                        AutoMediaPlaybackPolicy
                                            .require_user_action_for_all_media_types,
                                    initialUrl: snap.data['articles'][index]
                                        ['url'],
                                    javascriptMode: JavascriptMode.unrestricted,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
