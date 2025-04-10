import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/Photo%20Api/PhotosModel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(PhotosApi());
}

class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<PhotosModel> photoslist = [];

  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        photoslist.add(PhotosModel.fromJson(i));
      }
      return photoslist;
    }
    return photoslist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Photos API'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: photoslist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.cyanAccent,
                              backgroundImage:
                                  NetworkImage(photoslist[index].url!),
                            ),
                            title: Text(
                              snapshot.data![index].title.toString(),
                            ));
                      });
                }),
          ),
        ],
      ),
    );
  }
}
