
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';
import '../routes/app_routes.dart';


class UserTile extends StatelessWidget {

  final User user;

  const UserTile(
      this.user
      );

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
      ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                        AppRoutes.USER_FORM,
                        arguments: user,
                    );
                  },
                  color: Colors.blue,
                  icon: Icon(Icons.edit)
              ),
              IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Excluir Usuário'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            TextButton(
                                child: Text('Não'),
                                onPressed: (){
                                  Navigator.of(context).pop(false);
                                },
                            ),
                            TextButton(
                                child: Text('Sim'),
                                onPressed: (){
                                  Provider.of<Users>(context, listen: false).remove(user);
                                  Navigator.of(context).pop(true);
                                },
                            ),
                          ],
                        ),
                    ).then((value){
                        if(value == true){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Usuário Excluido com Sucesso!',
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.blue,
                            behavior: SnackBarBehavior.floating,
                            elevation: 6.0,
                          ));
                        }
                    });
                  },
                  color: Colors.red,
                  icon: Icon(Icons.delete)
              ),
            ],
          ),
        ),
    );
  }
}

