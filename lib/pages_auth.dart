import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pagesauthorization extends StatefulWidget {
  Pagesauthorization({Key? key}) : super(key: key);

  @override
  _PagesauthorizationState createState() => _PagesauthorizationState();
}

class _PagesauthorizationState extends State<Pagesauthorization> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginForm(),
    );
  }

  void _validation() async {
    final prefs = await SharedPreferences.getInstance();
    var _summ = _loginController.text + _passwordController.text;
    //int password=
    if (prefs.getInt('password') == _passwordController.text.hashCode) {
      if (_summ.hashCode == prefs.getInt('login')) {
        Navigator.pushNamed(context, '/ counter');
      }
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ошибка!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Введены неверные данные'),
                  Text('Вы можете заново зарегистрироваться'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Регистрация'),
                onPressed: () {
                  Navigator.pushNamed(context, '/ registration');
                },
              ),
              TextButton(
                child: const Text('Закрыть'),
                onPressed: () => exit(0),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _LoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: ListView(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              'Авторизуйтесь',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                labelText: 'Телефон',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
              ),
              onSaved: (String? value) {
              },
              validator: (String? val) =>
              val!.isEmpty ? 'Введите номер телефона' : null,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePass,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon:
                  Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(width: 60, height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    _validation();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFA120C9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                  child: const Text('Вход')),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                primary: Colors.purpleAccent,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ registration');
              },
              child: const Text('Зарегистрируйтесь'),
            )
          ],
        ),
      ),
    );
  }
}
