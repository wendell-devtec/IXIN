import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

import '../control_page.dart';
import '../../util/common.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;

class ProdutosHistoryPage extends StatefulWidget{
  const ProdutosHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProdutosHistoryPageState();

}

class _ProdutosHistoryPageState extends State<ProdutosHistoryPage> {
  String? formatDate;



  @override
  void initState() {
    _checkTime();
    super.initState();
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
    var url = "https://devtecapps.com.br/ixin/getHistoryListProdutos.php?loja=$storeName";
    final uri = Uri.tryParse(url);

    final response = await http.get(uri!);
    return jsonDecode(response.body);

  }

  Future<List<Map<String, dynamic>>> fetchProdutosAgrupadosPorPreco(int lojanumber) async {
    final response = await http.get(Uri.parse('https://devtecapps.com.br/ixin/getHistoryListProdutos.php?loja=$storeName'));
    final List<dynamic> produtosJson = jsonDecode(response.body);
    final List<Map<String, dynamic>> produtos = produtosJson.cast<Map<String, dynamic>>();
    return produtos;
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
      appBar: AppBar(
        title: Text("HISTÓRICO LOJA $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 15, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 15),
              child:IconButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(

                        builder: (BuildContext context)=> const ControlPage(),

                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.house))
          )
        ],
      backgroundColor: colorApp,
      ),
      backgroundColor: bck,
      body:FutureBuilder<List>(
        future:  fetchProdutosAgrupadosPorPreco(int.parse(storeName)),
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
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {

  List list;

  Items({super.key,  required this.list});



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx,i){
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
             Text("${list[i]['data']}", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white),),


              Card(

                color: Colors.black38,
                margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    child: ListTile(
                      subtitle: Text("Produto: ${list[i]['code']} - ${list[i]['nomeP']}\nVendedor: ${list[i]['vendedor']}"
                          "\nStatus: ${list[i]['status']}\nQtd separada: ${list[i]['qtd_separed']} pcs" ,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                      overflow: TextOverflow.clip
                      ),
                    )
                ),
              )
            ],
          );
        }
    );
  }
}
