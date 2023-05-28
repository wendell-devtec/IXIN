import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;

import '../../util/custom_button.dart';
import '../../util/text_field.dart';
import '../control_page.dart';


class SugestionAddPage extends StatefulWidget{
  const SugestionAddPage({super.key});

  @override
  State<StatefulWidget> createState() => _SugestionAddPageState();



}

class _SugestionAddPageState extends State<SugestionAddPage> {
  late FToast fToast;

  String? formatDate;
  String? formatDateWeb;

  String? status = "Pendente";


  @override
  void initState(){
    if(kIsWeb){
      DateTime now = DateTime.now();
      var dateFormat = DateFormat('dd/MM/yyyy').format(now);


      setState(() {
        formatDate = dateFormat;
      });

    }else{
      _checkTime();
    }

    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Future<void> _checkTime() async {
    DateTime ntpTime;


    ntpTime = await NTP.now();

    var dateFormat  = DateFormat('dd/MM/yyyy').format(ntpTime);

    setState(() {
      formatDate = dateFormat;
    });

    return;
  }


  @override
  Widget build(BuildContext context) {
    final nameControl = TextEditingController();
    final sacControl = TextEditingController();

    void addData(){


      const  url = "https://devtecapps.com.br/ixin/addSP.php";
      final uri = Uri.tryParse(url);

      http.post(uri!,body: {

        "nome": nameControl.text,
        "nome_p": sacControl.text,
        "status": status,
        "data": formatDate ,


      }).then((value) {
        String msg = "REGISTRO DE SUGESTÃO CONCLUIDO";
        _showToastCancel(msg);
        _homeRoute();
      });
    }
    Color colorApp;
    Color bck;

    if(kIsWeb){
      colorApp = Colors.black54;
      bck = Colors.black38;

    }else{
      colorApp = Theme.of(context).colorScheme.primary;
      bck = colorApp;

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADICIONAR SUGESTÃO", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colorApp,
      ),
        backgroundColor: bck,

      body: Container(
        color: bck,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.black,
                            child: Icon(FontAwesomeIcons.bagShopping, color: Colors.white,)
                        ),

                      ],
                    )
                )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                  children: [
                    textField(
                      hintText: "DIGITE SEU NOME",
                      icon: Icons.text_fields,
                      inputType: TextInputType.text,

                      maxLines: 1,
                      controller: nameControl,
                    ),

                    textField(
                      hintText: "DIGITE QUAL PRODUTO SERÁ SUGERIDO",
                      icon: Icons.comment,
                      inputType: TextInputType.text,
                      maxLines: 2,
                      controller: sacControl,
                    ),


                    Padding(padding: const EdgeInsets.only(left: 15, right: 15),
                      child:  SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            var msg = "DIGITE SEU NOME PARA PROSSEGUIR";
                            if(nameControl.text.isEmpty){
                              _showToastCancel(msg);
                              return;
                            }
                            if(sacControl.text.isEmpty){
                              var msg = "DIGITE O PRODUTO A SER SUGERIDO";
                              _showToastCancel(msg);
                              return;
                            }

                            addData();


                          },
                          text: "ENVIAR",
                        ),
                      ),
                    )


                  ]
              ),
            )
          ],
        ),
      ),
    );
  }

  void _homeRoute() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const ControlPage()));

  }

  _showToastCancel(msg) {
    Widget toastWithButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text("$msg", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold , color: Colors.white , fontFamily: 'SuperCell')),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toastWithButton,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }
}

