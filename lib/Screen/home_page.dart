import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/common.dart';
import '../../util/custom_button.dart';
import '../../util/text_field.dart';
import 'control_page.dart';



class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}



class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final storeControl = TextEditingController();
  final passControl = TextEditingController();
  late GlobalKey<ArtDialogState> _artDialogKey;



    Future<void> _login() async {
      final response = await http.post(Uri.parse("https://devtecapps.com.br/ixin/login.php"),
          body: {"user": storeControl.text, "pass": passControl.text});

      final data = json.decode(response.body);

      if (data["success"] == 1) {

        final loja = data["loja"];
        final latitude = data["latitude"];
        final longitude = data["longitude"];

        final loginData = LoginData(loja: loja, latitude: latitude , longitude: longitude);
        LoginSingleton.setLoginData(loginData);


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', storeControl.text);
        prefs.setString('pass', passControl.text);


        _homeRote();

      } else {
        _loginErro();
      }
    }

  @override
  void initState() {
    super.initState();
    _artDialogKey =  GlobalKey<ArtDialogState>();
    verifiedLogin();

  }

  Future<void> verifiedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    if (username != null && password != null) {
      final response = await http.post(Uri.parse("https://devtecapps.com.br/ixin/login.php"),
          body: {"user": username, "pass": password});
      final data = json.decode(response.body);
      if (data["success"] == 1) {
        final loja = data["loja"];
        final latitude = data["latitude"];
        final longitude = data["longitude"];
        final loginData = LoginData(loja: loja, latitude: latitude , longitude: longitude);
        LoginSingleton.setLoginData(loginData);
        _homeRote();
      }
    }

  }


  Image imageLogo = Image.asset("assets/images/logo.png", fit: BoxFit.fill);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final bool isMobile = constraints.maxWidth < 600;

      return Scaffold(
        appBar: isMobile ? AppBar(
          title: const Text("ACESSAR SISTEMA", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ) : AppBar(
          title: const Text("ACESSAR SISTEMA DESKTOP", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),

        body: isMobile ?
        Container(
          color: Theme
              .of(context)
              .colorScheme
              .secondary,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: imageLogo.image,
                            radius: 60,
                          ),
                        ],
                      )
                  )
              ),

              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                        children: [
                          textField(
                            hintText: "90",
                            icon: Icons.store_mall_directory_rounded,
                            inputType: TextInputType.emailAddress,
                            maxLines: 1,
                            controller: storeControl,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'DIGITE O USUÁRIO';
                              }
                              return null;
                            },

                          ),

                          textField(
                            hintText: "abc123456",
                            icon: Icons.password_sharp,
                            inputType: TextInputType.text,
                            maxLines: 1,
                            controller: passControl,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'DIGITE A SENHA';
                              }
                              return null;
                            },
                          ),


                          Padding(padding: const EdgeInsets.only(left: 15, right: 15),
                            child:  SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CustomButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _login();
                                  }

                                },
                                text: "ACESSAR",
                              ),
                            ),
                          )


                        ]
                    ),
                  )
              ),


            ],
          ),
        ) : Container(
          color: Colors.black38,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: imageLogo.image,
                            radius: 80,
                          ),
                        ],
                      )
                  )
              ),

              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 500,
                            child:textField(
                              hintText: "loja01",
                              icon: Icons.store_mall_directory_rounded,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: storeControl,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'DIGITE O USUÁRIO';
                                }
                                return null;
                              },

                            ),

                          ),

                          SizedBox(
                            height: 80,
                            width: 500,
                            child: textField(
                              hintText: "abc123456",
                              icon: Icons.password_sharp,
                              inputType: TextInputType.text,
                              maxLines: 1,
                              controller: passControl,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'DIGITE A SENHA';
                                }
                                return null;
                              },
                            ),

                          ),

                          Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                            child:  SizedBox(
                              width: 250,
                              height: 50,
                              child: CustomButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _login();
                                  }

                                },
                                text: "ACESSAR",
                              ),
                            ),
                          )


                        ]
                    ),
                  )
              ),


            ],
          ),
        ),
      );
    });
  }

  void _homeRote() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const ControlPage()));
  }

  Future<void> _loginErro() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          title: "ERRO AO TENTAR SE LOGAR VERIFICAR COM SUPORTE T.I",
          onConfirm: () async  {
            _artDialogKey.currentState?.closeDialog();

          },


          onDeny: (){
            _artDialogKey.currentState?.closeDialog();
          },

          onDispose: () {
            _artDialogKey = GlobalKey<ArtDialogState>();
          },
        )
    );

  }


}



