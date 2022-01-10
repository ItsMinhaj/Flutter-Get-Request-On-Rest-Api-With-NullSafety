import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_post_api/model/post_model.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  List<PostModel> postList = [];

  fetchApi() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var jsonString = response.body;
    var data = jsonDecode(jsonString);

    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GET REQUEST ON REST API"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postList[index].title.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text("\nDescription\n" +
                              postList[index].body.toString()),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
