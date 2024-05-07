import 'package:flutter/material.dart';
import 'package:news_app/components/app_bar.dart';
import 'package:news_app/components/new_box.dart';
import 'package:news_app/components/search_bar.dart';
import 'package:news_app/services/api.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  static String imageurl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGkAznCVTAALTD1o2mAnGLudN9r-bY6klRFB35J2hY7gvR9vDO3bPY_6gaOrfV0IHEIUo&usqp=CAU';
  String searchTerm = "";
  Future<List> fetchNews() {
    return fetch(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                onSearch: () {
                  setState(() {
                    searchTerm = SearchBarWidget.searchcontroller.text;
                  });
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: FutureBuilder<List>(
                  future: fetchNews(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return NewBox(
                            imageurl:
                                snapshot.data![index]["urlToImage"] ?? imageurl,
                            title: snapshot.data![index]["title"],
                            time: snapshot.data![index]["publishedAt"],
                            description: snapshot.data![index]["description"] ??
                                'No Description',
                            url: snapshot.data![index]["url"],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
