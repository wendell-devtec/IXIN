import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ixin/Screen/control_page.dart';
import 'package:ntp/ntp.dart';
import '../util/custom_button.dart';
import '../util/text_field.dart';
import 'package:http/http.dart' as http;


class SacPage extends StatefulWidget{
  const SacPage({super.key});

  @override
  State<StatefulWidget> createState() => _SacPageState();



}

class _SacPageState extends State<SacPage> {
  late FToast fToast;
  String? formatDate;


  @override
  void initState(){
    if(kIsWeb){
      DateTime now = DateTime.now();
      var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);


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

    var dateFormat  = DateFormat('dd/MM/yyyy HH:mm:ss').format(ntpTime);

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


      const  url = "https://devtecapps.com.br/ixin/addOuvidoria.php";
      final uri = Uri.tryParse(url);

      http.post(uri!,body: {

        "nome": nameControl.text,
        "sac_text": sacControl.text,
        "data": formatDate
      }).then((value) {
        String msg = "OUVIDORIA ENVIADA COM SUCESSO";
        _showToastCancel(msg);
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
        title: const Text("OUVIDORIA", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
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
                            child: Icon(FontAwesomeIcons.phone, color: Colors.white,)
                        ),

                      ],
                    )
                )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                  children: [
                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.only(left: 15),
                          child:Text("DIGITE SEU NOME CASO QUEIRA.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                        )

                      ],
                    ),
                    textField(
                      hintText: "EX PEDRO CARLOS",
                      icon: Icons.text_fields,
                      inputType: TextInputType.text,
                      maxLines: 1,
                      controller: nameControl,
                    ),

                    textField(
                      hintText: "DIGITE AQUI SEU ELOGIO/ RECLAMAÇÃO // SUGESTÃO ...",
                      icon: Icons.comment,
                      inputType: TextInputType.text,
                      maxLines: 5,
                      controller: sacControl,
                    ),


                    Padding(padding: const EdgeInsets.only(left: 15, right: 15),
                      child:  SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            if(sacControl.text.isNotEmpty){
                              addData();
                              ArtDialogResponse response = await ArtSweetAlert.show(
                                  barrierDismissible: false,
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                      title: "Ouvidoria enviada com sucesso",
                                      text: "Nenhuma informação como loja ou local foi coletado pelo APP, todas as informações estão em sigilo",
                                      confirmButtonText: "OK , voltar ao inicio",
                                      type: ArtSweetAlertType.warning
                                  )
                              );

                              if(response.isTapConfirmButton) {
                                _homeRoute();
                                return;
                              }
                            }else{
                               String msg = "DIGITE SUA MENSAGEM PARA PROSSEGUIR";
                              _showToastCancel(msg);
                            }


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

  void _homeRoute() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const ControlPage()));

  }
}

