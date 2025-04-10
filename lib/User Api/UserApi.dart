import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/User%20Api/UserApiModel.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(UserApi());
}

class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  List<UserApiModel> userslist = [];

  Future<List<UserApiModel>> getUserdata() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userslist.add(UserApiModel.fromJson(i));
      }
      return userslist;
    }
    return userslist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User API'),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserdata(),
                  builder:
                      (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: userslist.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Email',
                                    value:
                                        snapshot.data![index].email.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Phone',
                                    value:
                                        snapshot.data![index].phone.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Address',
                                    value: snapshot.data![index].address
                                        .toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Company',
                                    value: snapshot.data![index].company
                                        .toString(),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({required this.title, required this.value, super.key});

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

