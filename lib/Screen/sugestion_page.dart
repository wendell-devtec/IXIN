import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixin/util/common.dart';
import 'add_page/sugestion_add.dart';

class SugestaoPage extends StatefulWidget{
  const SugestaoPage({super.key});

  @override
  State<StatefulWidget> createState() => _SugestaoPageState();

}

class _SugestaoPageState extends State<SugestaoPage> {

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
        title: const Text("PRODUTOS SUGERIDOS", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 16, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colorApp,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 15),
          child:IconButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(

                    builder: (BuildContext context)=> const SugestionAddPage(),

                  ),
                );
              },
              icon: const Icon(FontAwesomeIcons.plus))
          )

        ],
      ),
      body:FutureBuilder<List>(
        future: getSP(),
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
              child: CircularProgressIndicator()
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
          return Card(

            color: Colors.black38,
            margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              child: ListTile(
                title: Text("Produto: ${list[i]['nome_p']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                subtitle: Text("Data: ${list[i]['data']}\nNome: ${list[i]['nome']}\nStatus: ${list[i]['status']}" ,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
              )
            ),
          );
        }
    );
  }
}
