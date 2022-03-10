import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'user_id.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late Future<List<User>> userlist;
  @override
  void initState() {
    super.initState();
    userlist = getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCase(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Go to the next page',
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text('Список пользователей'),
      ),
      body: FutureBuilder<List<User>>(
        future: userlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Имя: ${snapshot.data![index].name}'),
                      subtitle: Text('Email: ${snapshot.data![index].email}'),
                      leading: Text('ID: ${snapshot.data![index].id}'),
                      onTap: () async {
                        UserID uid = UserID(
                            snapshot.data![index].id,
                            '${snapshot.data![index].name}',
                            '${snapshot.data![index].username}',
                            '${snapshot.data![index].email}',
                            '${snapshot.data![index].address!.street}',
                            '${snapshot.data![index].address!.suite}',
                            '${snapshot.data![index].address!.city}',
                            '${snapshot.data![index].address!.zipcode}',
                            '${snapshot.data![index].address!.geo!.lat}',
                            '${snapshot.data![index].address!.geo!.lng}',
                            '${snapshot.data![index].phone}',
                            '${snapshot.data![index].website}',
                            '${snapshot.data![index].company!.name}',
                            '${snapshot.data![index].company!.catchPhrase}',
                            '${snapshot.data![index].company!.bs}');

                        Navigator.pushNamed(context, '/ infoUser',
                            arguments: uid);
                      },
                    ),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> getUserList() async {
    List<User> prodList = [];
    const url = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        prodList.add(User.fromJson(prod));
      }
      return prodList;
    } else {
      throw Exception('Ошибка: ${response.reasonPhrase}');
    }
  }
}

class DrawerCase extends StatelessWidget {
  const DrawerCase ({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
            child: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height : 90,
                    child: Image(image: AssetImage('assets/heart.png'),),
                  ),
                  SizedBox(height: 20),
                  const Text("Место под логотип с подписью",
                  style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.water_damage,
              color: Colors.deepPurple,
            ),
            title: const Text('Пункт №1'),
            onTap: () {},
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.wifi_rounded,
              color: Colors.deepPurple,
            ),
            title: const Text('Пункт №2'),
            onTap: () {},
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.watch_later,
              color: Colors.deepPurple,
            ),
            title: const Text('Пункт №3'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
