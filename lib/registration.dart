import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _returnpasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _returnpasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(45.0),
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Регистрация',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black45
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Введите имя',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
              ),
              onSaved: (String? value) {
              },
              validator: (String? val) =>
              val!.isEmpty ? 'Введите имя' : null,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                labelText: 'Введите номер телефона',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
              ),
              onSaved: (String? value) {
              },
              validator: (String? val) =>
              val!.isEmpty ? 'Введите номер телефона' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePass,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
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
              validator: _vall,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _returnpasswordController,
              obscureText: _hidePass,
              maxLength: 10,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),

                labelText: 'Повторить пароль',
              ),
              validator: _vall,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(width: 60, height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFA120C9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _validation();
                    }
                  },
                  child: const Text('Зарегистрироваться')),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                primary: Colors.purpleAccent,
              ),
              onPressed: () => exit(0),
              child: const Text('Закрыть'),
            )
          ],
        ),
      ),
    );
  }

  String? _vall(String? value) {
    if (_passwordController.text.length != 10) {
      return 'Пароль должен содержать 10 символов';
    } else if (_passwordController.text != _returnpasswordController.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }

  void _validation() async {
    final prefs = await SharedPreferences.getInstance();
    var _summ = _loginController.text + _passwordController.text;
    prefs.setInt('password', _passwordController.text.hashCode);
    prefs.setInt('login', _summ.hashCode);
    prefs.setString('name', _nameController.text);
    _showDialogRegistration(prefs: prefs);
  }

  Future<void> _showDialogRegistration({prefs}) async {
    var name = prefs.getString('name');
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Готово! $name'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Регистрация пройдена.'),
                Text('Вы можете продолжить использовать приложение'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Продолжить'),
              onPressed: () {
                Navigator.pushNamed(context, '/');
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
