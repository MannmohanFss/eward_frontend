import 'package:eward_frontend/screens/userscreen/userhmscreen.dart';
import 'package:eward_frontend/screens/memberscreen/memberhmscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eward_frontend/apicall/apirequest.dart';
import 'package:eward_frontend/screens/authentication/signupscreen.dart';
import 'package:eward_frontend/screens/adminscreens/adminhomepage.dart';
import 'package:eward_frontend/screens/adminscreens/adminnav.dart';

class loginscreen extends StatelessWidget {
  loginscreen({super.key});
  final t1 = TextEditingController();
  final t2 = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 350,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(children: [
                    Positioned(
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        )),
                    Positioned(
                        width: 80,
                        height: 150,
                        left: 90,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        )),
                    Positioned(
                        width: 120,
                        height: 180,
                        right: 30,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        ))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(68, 0, 0, 0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(252, 0, 0, 0),
                                  blurRadius: 30.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Form(
                          key: formkey,
                          child: Column(children: [
                            Container(
                              width: 400,
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 189, 181, 189)),
                                controller: t1,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              width: 400,
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                obscureText: true,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 71, 63, 65)),
                                controller: t2,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: 430,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(87, 90, 142, 1),
                              Color.fromRGBO(143, 148, 251, 2)
                            ])),
                        child: ElevatedButton(
                          onPressed: (() {
                            if (formkey.currentState!.validate()) {
                              checkcredentails(context);
                            }
                          }),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text("Login", style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Does not have account?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return userRegistration();
                        })));
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ));
  }

  void checkcredentails(BuildContext contex) async {
    final sharedpref = await SharedPreferences.getInstance();

    final username = t1.text.toString();
    final password = t2.text.toString();

    if ((username == "admin@gmail.com") && (password == "admin")) {
      sharedpref.setString('utype', 'admin');
      Navigator.of(contex)
          .pushReplacement(MaterialPageRoute(builder: ((contex) {
        return adminhomenav();
      })));
    }

    Map<String, dynamic> resp = await singinapi(username, password);
    if (resp['token'] != null) {
      String utype = resp['user']['utype'];
      String token = resp['token'];
      int id = resp['user']['id'];
      String email = resp['user']['email'];
      sharedpref.setString('token', token);
      sharedpref.setInt('id', id);
      sharedpref.setString('utype', utype);
      sharedpref.setString('email', email);
      if (utype == "user") {
        Navigator.of(contex)
            .pushReplacement(MaterialPageRoute(builder: ((contex) {
          return userhomescreen();
        })));
      } else if (utype == "memb") {
        Navigator.of(contex)
            .pushReplacement(MaterialPageRoute(builder: ((contex) {
          return membhomescreen();
        })));
      }
    } else {
      ScaffoldMessenger.of(contex).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(resp['error']),
      ));
    }
  }
}
