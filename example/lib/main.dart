import 'package:flutter/material.dart';
import 'package:network_caller/base_network_caller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = 'Loading';

  Future<void> getPosts() async {
    final response = await BaseNetworkCaller.getRequest(
        'https://jsonplaceholder.typicode.com/posts',
        onUnAuthorized: () {});
    text = response.returnValue.toString();
    setState(() {});
  }

  Future<void> getUsers() async {
    final response = await BaseNetworkCaller.getRequest(
        'http://restapi.adequateshop.com/api/users',
        token: '4f7d7422-b435-48ad-b9ba-bb0ccc724613',
        onUnAuthorized: () {});
    print(response.responseCode);
    print(response.returnValue);
    // text = response.returnValue.toString();
    // setState(() {});
  }

  Future<void> registration() async {
    final response = await BaseNetworkCaller.postRequest(
        'http://restapi.adequateshop.com/api/authaccount/registration',
        {
          "name":"example",
          "email":"example@gmail.com",
          "password":123456
        },
        isLogin: true,
        onUnAuthorized: () {});
    print(response.responseCode);
    print(response.returnValue.toString());
    // text = response.returnValue.toString();
    // setState(() {});
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getPosts();
      // registration();
      getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
