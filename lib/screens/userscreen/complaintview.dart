import 'package:flutter/material.dart';
import 'package:eward_frontend/screens/userscreen/compregscreen.dart';
import 'package:eward_frontend/apicall/apirequest.dart';
import 'package:eward_frontend/screens/userscreen/compscreen.dart';

class compscreen extends StatelessWidget {
  const compscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
     
      child: Scaffold(
         appBar: AppBar(title:Text("Complaints")),
          body: FutureBuilder<List<dynamic>>(
            future: Future.value(complaints()),
            builder:
                ((BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
            
            return Center(child: Text("No Complaints"));
          }
                final data = snapshot.data;
                return ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: ((BuildContext context, int index) {
                      final user = snapshot.data?[index];
                      String complaint_id = user['id'].toString();
                      String complaint_title = user['name'];
                      String complaint_desc = user['desc'];
                      String complaint_created = user['created_on'];
                      String complaint_updated = user['update_on'];
                      String complaint_imgpath = user['img_path'];
                      String complaint_status = user['status'];

                      return Card(
                        color:Color.fromARGB(0, 27, 7, 250) ,
                          elevation: 0,
                          child: SizedBox(
                            height: 100,
                            child: ListTile(
                              leading:
                                  Image.asset("assets/images/notification.png"),
                              title: Text(complaint_title),
                              subtitle: Text(complaint_desc,
                                  overflow: TextOverflow.ellipsis),
                              trailing: Text(complaint_updated),
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return complaintscreen(
                                    complaintId: complaint_id,
                                    complaintTitle: complaint_title,
                                    complaintDesc: complaint_desc,
                                    complaintCreated: complaint_created,
                                    complaintImgpath: complaint_imgpath,
                                    complaintStatus: complaint_status,
                                    complaintUpdated: complaint_updated,
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
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return compregscreens();
                })));
              },
              child: const Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
    );
  }
}
//compileSdkVersion flutter.compileSdkVersion