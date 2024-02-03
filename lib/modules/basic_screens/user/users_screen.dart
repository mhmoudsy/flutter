import 'package:flutter/material.dart';
import 'package:fproject/models/user/user_model.dart';



class UsersScreen extends StatelessWidget {
  List<UserModel> user = [
    UserModel(id: 1,
        name: 'Mhmoud',
        phone: '01121346770'
    ),
    UserModel(id: 2,
        name: 'Mhmd',
        phone: '0125471000'
    ),
    UserModel(id: 2,
        name: 'Amira',
        phone: '01013477941'
    ),
    UserModel(id: 1,
        name: 'Mhmoud',
        phone: '01121346770'
    ),
    UserModel(id: 2,
        name: 'Mhmd',
        phone: '0125471000'
    ),
    UserModel(id: 2,
        name: 'Amira',
        phone: '01013477941'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => BuildUserItem(user[index]),
            separatorBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
            itemCount: user.length));
  }

  Widget BuildUserItem(UserModel x) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Text(
                "${x.id}",
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${x.name}',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '+${x.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
