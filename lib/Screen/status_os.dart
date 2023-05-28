import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixin/Screen/add_page/os_add.dart';
import 'package:ixin/Screen/history/os_history.dart';

import '../util/common.dart';
import '../util/custom_button.dart';
import 'control_page.dart';
import 'package:http/http.dart' as http;


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;

class OrdemService extends StatefulWidget{
  const OrdemService({super.key});

  @override
  State<StatefulWidget> createState() => _StateOrdemService();

}


class _StateOrdemService extends State<OrdemService> {

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: timer), (Timer timer) {setState(() {});});
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
        title: Text("ORDEM DE SERVIÇO $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 14, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colorApp,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 15),
              child:IconButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(

                        builder: (BuildContext context)=> const OsHistoryPage(),

                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.clockRotateLeft))
          ),

          Padding(padding: const EdgeInsets.only(right: 15),
              child:IconButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(

                        builder: (BuildContext context)=> const ControlPage(),

                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.house))
          )

        ],
      ),
      body:Stack(
        children: [
          FutureBuilder<List>(
            future: getOs(int.parse(storeName)),
            // future: getData(_lojanumber!),
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


          Positioned(
            bottom: 30,
            right: 10,
            child:Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child:  SizedBox(
                child: CustomButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const OsAddPage()));

                  },
                  text: "ADCIONAR OS" ,
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {

  List list;


  Items({super.key,  required this.list});

  String? status;
  int? product;


  Future<void> editOs() async {


    var url = "https://devtecapps.com.br/ixin/editOs.php";
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
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Card(

                color: Colors.black38,
                margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${list[i]['data']} - OS ${list[i]['os_number']}", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white)),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Produto: ", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 14, color: Colors.white)),
                              Text("${list[i]['produto']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white)),
                            ],
                          ),

                          Row(
                            children: [
                              const Text("Vendedor: ", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 14,color: Colors.white)),
                              Text("${list[i]['vendedor']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Status: ", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 14,  color: Colors.white)),
                              Text("${list[i]['status']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white)),

                            ],
                          )
                        ],
                      ),
                      onTap: () async {
                        await ArtSweetAlert.show(
                            barrierDismissible: false,
                            artDialogKey: artDialogKey,
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                              denyButtonText: "NÃO",
                              title: "A OS ${list[i]['os_number']} FOI FINALIZADA ??",

                              onConfirm: () async  {
                                artDialogKey.currentState?.closeDialog();
                                status = "FINALIZADA";
                                product = int.parse(list[i]['id']);
                                editOs();

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
              )
            ],
          );
        }
    );
  }
}
