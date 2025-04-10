import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(PostApi());
}

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  void postApi() async {
    try {
      var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {
          'name': 'Atif',
          'Age': '23',
        },
      );
      print(response.body);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post API'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: postApi,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue, // Text color
          ),
          child: Text('Post Data'),
        ),
      ),
    );
  }
}
