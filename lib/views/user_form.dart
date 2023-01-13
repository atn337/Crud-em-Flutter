

import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user){
    if(user != null ) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = ModalRoute.of(context)?.settings?.arguments;
    if(user is User) {
      _loadFormData(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Usuário'),
        toolbarHeight: 70,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              final isValid = _form.currentState!.validate();

              if(isValid){
                _form.currentState?.save();
                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'].toString(),
                  name: _formData['name'].toString(),
                  email: _formData['email'].toString(),
                  avatarUrl: _formData['avatarUrl'].toString(),
                  ),
                );
                Navigator.of(context).pop(); //fechar tela
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _formData['name'],
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value){
                      if(value == null || value.trim().isEmpty) {
                        return 'Nome inválido!';
                      }
                      if(value.trim().length < 3){
                        return 'Nome pequeno, mínimo de três letras!';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['name'] = value!,
                  ),
                  TextFormField(
                    initialValue: _formData['email'],
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onSaved: (value) => _formData['email'] = value!,
                  ),
                  TextFormField(
                    initialValue: _formData['avatarUrl'],
                    decoration: InputDecoration(labelText: 'Url do Avatar'),
                    onSaved: (value) => _formData['avatarUrl'] = value!,
                  ),
                ],
              ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
