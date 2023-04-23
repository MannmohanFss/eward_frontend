import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:eward_frontend/apicall/apirequest.dart';

class MyWidget extends StatelessWidget {
  String? id;
  MyWidget({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<dynamic>>(
          future: Future.value(get_chat(id)),
          builder:
              ((BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.builder(
                  itemCount: data?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: ((BuildContext context, int index) {
                    final user = snapshot.data?[index];
                    String messgae = user['comment'];
                    String users = user['user'];
                    String time = convert(user['update_on']);

                    return Card(
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            // mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text(users,style: TextStyle(fontSize: 15),),
                              SizedBox(height: 4),
                              Text(":"),
                              Text(messgae),
                             
                             ],),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                        
                               children: [
                                
                                 Text(time),
                               ],
                             )
                            ],
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
      ),
    );
  }
  String  convert(sample) {
  
  List<String> data=sample.split('T');
  String date=data[0];
  String time=data[1].split('.')[0];
  return '$date $time';
  
}
}
