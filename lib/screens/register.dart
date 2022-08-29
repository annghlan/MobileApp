import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:individualproject/screens/login.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  //Text input Field ma enter gareko data lai store garne variable

  @override //when a child class tries to override the parent class's method
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        //used to implements the basic material design visual layout structure.
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 33),
              ),
            ),
            // create an account

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailcontroller,
                            style:
                                TextStyle(color: Color.fromARGB(255, 7, 7, 7)),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),

                          // box bhitra ko email text

                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordcontroller,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up', //signup
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                //arko page ma jana icon circle wala
                                radius: 30,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                child: IconButton(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    onPressed: RegisterIntoFirebase,
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RegisterIntoFirebase() {
    // check email and password field is not empty
    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
      // if any exception occurs then it should be handled
      try {
        // creating user login with email and password
        // by the use of firebase auth

        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text.trim(),
                password: passwordcontroller.text.trim())
            .then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyLogin()));
          print("Login sucessfull");
        }).onError((error, stackTrace) {
          print(error);
          print("unsucesful");
        });
      } catch (e) {}
    }
  }
}
