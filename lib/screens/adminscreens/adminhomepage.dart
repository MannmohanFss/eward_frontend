import 'package:eward_frontend/apicall/apirequest.dart';
import 'package:flutter/material.dart';
import 'package:eward_frontend/screens/adminscreens/memberView.dart';
import 'package:eward_frontend/screens/adminscreens/registerMember.dart';

class adminHomeScreen extends StatelessWidget {
  const adminHomeScreen({super.key,String? response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return memberReg();
            }));
          },
          child: const Text("+")),
      body: FutureBuilder<List<dynamic>>(
        future: Future.value((getmembers())),
        builder:
            ((BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length ?? 0,
                itemBuilder: ((BuildContext context, int index) {
                  final user = snapshot.data?[index];
                  String email = user['email'];
                  String firstname = user['firstname'];
                  String lastname = user['lastname'];
                  String ward = user['ward'];
                  String phone = user['phone'];
                  String gender = user['gender'];

                  return Card(
                      elevation: 5,
                      child: SizedBox(
                        height: 100,
                        child: ListTile(
                          title: Text(firstname + ' ' + lastname,
                              style: TextStyle(fontSize: 20)),
                          subtitle: Text(
                            'Ward $ward',
                            style: TextStyle(fontSize: 19),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return memberview(
                                email: email,
                                name: firstname + ' ' + lastname,
                                ward: ward,
                                phone: phone,
                                gender: gender,
                              );
                            })));
                          },
                        ),
                      ));
                }));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
