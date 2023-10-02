
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacco/src/core/widgets/data_provider.dart';
import 'package:vacco/src/features/auth/models/users_model.dart';

import '../../../core/data_state.dart';
import '../../../core/form_validator.dart';
import '../../../core/providers.dart';
import '../../../core/styles.dart';
import '../../../core/widgets/loading_widget.dart';

class ListUserView extends ConsumerStatefulWidget {
  const ListUserView({Key? key}) : super(key: key);

  @override
  ListUserViewState createState() => ListUserViewState();
}

class ListUserViewState extends ConsumerState<ListUserView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  

  

  @override
  Widget build(BuildContext context) {
    final _data= ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Users"),
      ),
      body: _data.when(
          data: (_data){
            List<UserModel> userList = _data.map((e) => e).toList();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                      Expanded(child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (_,index){
                        return InkWell(
                          
                          child: Card(
                          
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(userList[index].firstname, style: const TextStyle(
                                  color: Colors.black
                              ),),
                              subtitle: Text(userList[index].lastname, style: const TextStyle(
                                  color: Colors.black
                              )),
                              trailing: CircleAvatar(
                                backgroundImage: NetworkImage(userList[index].avatar),
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              ),
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}