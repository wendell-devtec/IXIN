import 'dart:async';
import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ixin/Screen/add_page/suprimentos_add.dart';
import 'package:ntp/ntp.dart';
import '../../util/common.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;
class SuprimentosPage extends StatefulWidget{
  const SuprimentosPage({super.key});



  @override
  State<StatefulWidget> createState() => _SuprimentosPageState();

}

class _SuprimentosPageState extends State<SuprimentosPage> {
  String? formatDate;
  late Timer _timer;

  @override
  void initState() {
    _checkTime();
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: timer), (Timer timer) {setState(() {});});
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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


  Future<List> getData(int lojanumber) async{
    var url = "https://devtecapps.com.br/ixin/getListSuprimentos.php?loja=$storeName";
    final uri = Uri.tryParse(url);

    final response = await http.get(uri!);
    return jsonDecode(response.body);

  }


  @override
  Widget build(BuildContext context) {

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
      backgroundColor: bck,
      appBar: AppBar(
        title: Text("SUPRIMENTOS LOJA $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 15, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colorApp,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 15),
              child:IconButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(

                        builder: (BuildContext context)=> const SuprimentosAddPage(),

                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.plus))
          )

        ],
      ),
      body:FutureBuilder<List>(
        future: getData(int.parse(storeName)),
        builder: (ctx,ss) {
          if(ss.hasError){

            if (kDebugMode) {
              print(ss.error);
            }

          }
          if(ss.hasData){
            return Items(list:ss.data!);

          }
          else{
            return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                )
            );


          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {

  List list;

  Items({super.key,  required this.list});

  String? status;
  int? product;


  Future<void> editData() async {


    var url = "https://devtecapps.com.br/ixin/editListSuprimentos.php";
    final uri = Uri.tryParse(url);

    http.post(uri!,body: {

      'id': "$product",
      'status': status ,
    });


  }



  @override
  Widget build(BuildContext context) {

    late GlobalKey<ArtDialogState> artDialogKey;

    artDialogKey =  GlobalKey<ArtDialogState>();



    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx,i){
          return Card(
            elevation: 2,
            color: Colors.black38,
            margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.sprayCan , color: Colors.white,),
                  title: Row(
                    children: [
                      const Text("SUPRIMENTO: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold , color: Colors.white ,fontFamily: 'SuperCell')),
                      Text("${list[i]['nomeS']} ", style: const TextStyle(fontSize: 18, color: Colors.white , fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Text("STATUS: " , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white , fontFamily:  'SuperCell')),
                      Text("${list[i]['status']}" , style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white))

                    ],
                  ),

                  onTap: () async {
                    await ArtSweetAlert.show(
                        barrierDismissible: false,
                        artDialogKey: artDialogKey,
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          denyButtonText: "NÃO",
                          title: "VOCÊ RECEBEU OS PRODUTOS?",

                          onConfirm: () async  {
                            artDialogKey.currentState?.closeDialog();
                            //product = list[i]['id'];
                            status = "Recebido - OK";
                            product = int.parse(list[i]['id']);
                            editData();

                          },


                          onDeny: (){
                            artDialogKey.currentState?.closeDialog();
                          },

                          onDispose: () {
                            artDialogKey = GlobalKey<ArtDialogState>();
                          },
                        )
                    );
                  },
                )
            ),
          );
        }
    );
  }
}
