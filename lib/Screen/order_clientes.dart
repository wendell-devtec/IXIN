
import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixin/Screen/add_page/order_add.dart';
import '../../util/common.dart';
import 'package:http/http.dart' as http;


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;


class OrderClientesPage extends StatefulWidget{
  const OrderClientesPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderClientesPageState();

}

class _OrderClientesPageState extends State<OrderClientesPage> {
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
        title: Text("ENCOMENDA LOJA $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 16, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colorApp,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 15),
              child:IconButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(

                        builder: (BuildContext context)=> const OrderAddPage(),

                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.plus))
          )

        ],
      ),
      body:FutureBuilder<List>(
        future: getEncomenda(int.parse(storeName)),
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


    var url = "https://devtecapps.com.br/ixin/editListOrder.php";
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

            color: Colors.black38,
            margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
                child: ListTile(
                  title: Text("Produto: ${list[i]['nomeP']} ", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                  subtitle: Text("Data: ${list[i]['data']}\nVendedor: ${list[i]['vendedor']}\nStatus: ${list[i]['status']}" ,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                  onTap: () async {
                    await ArtSweetAlert.show(
                        barrierDismissible: false,
                        artDialogKey: artDialogKey,
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          denyButtonText: "NÃO",
                          title: "Cliente já retirou o pedido?",

                          onConfirm: () async  {
                            artDialogKey.currentState?.closeDialog();
                            //product = list[i]['id'];
                            status = "RETIRADO PELO CLIENTE";
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
