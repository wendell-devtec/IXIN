import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../control_page.dart';
import '../../util/common.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;

class OsHistoryPage extends StatefulWidget{
  const OsHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _OsHistoryPageState();

}

class _OsHistoryPageState extends State<OsHistoryPage> {
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
        title: Text("HISTÓRICO OS $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 15, fontWeight: FontWeight.bold),),
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
        future:  getHistoryOs(int.parse(storeName)),
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
                    )
                ),
              )
            ],
          );
        }
    );
  }
}
