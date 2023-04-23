import 'package:flutter/material.dart';
import 'package:eward_frontend/screens/userscreen/notifiscreen.dart';
import 'package:eward_frontend/apicall/apirequest.dart';

class notificationview extends StatelessWidget {
  const notificationview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Notifications")),
      backgroundColor: Color.fromARGB(31, 219, 112, 11),
        body: FutureBuilder<List<dynamic>>(
        
      future: Future.value(notification()),
      builder: ((BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.data?.length == 0) {
            
            return Center(child: Text("No Notifications"));
          }
        if (snapshot.hasData) {
          final data = snapshot.data;
          return ListView.builder(
            
              itemCount: data?.length ?? 0,
              itemBuilder: ((BuildContext context, int index) {
                final user = snapshot.data?[index];
                String notification_title = user['name'];
                String notification_desc = user['desc'];
                String notification_created = user['created_on'];
                String notification_updated = user['update_on'];
                String notification_imgpath = user['img_path'];
                return Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 100,
                      child: ListTile(
                        leading: Image.asset("assets/images/notification.png"),
                        title: Text(notification_title),
                        trailing: Text(notification_updated),
                        subtitle: Text(notification_desc,overflow: TextOverflow.ellipsis),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return notificationscreen(
                                notification_title: notification_title,
                                notification_desc: notification_desc,
                                notification_created: notification_created,
                                notification_updated: notification_updated,
                                notification_imgpath: notification_imgpath);
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
    ));
  }
}
