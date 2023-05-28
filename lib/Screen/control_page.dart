import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ixin/Screen/close_page.dart';
import 'package:ixin/Screen/open_page.dart';
import 'package:ixin/Screen/produto_clientes.dart';
import 'package:ixin/Screen/sac_page.dart';
import 'package:ixin/Screen/status_os.dart';
import 'package:ixin/Screen/sugestion_page.dart';
import 'package:ixin/Screen/suprimentos_page.dart';
import 'package:ntp/ntp.dart';

import '../util/common.dart';
import '../util/custom_button.dart';
import '../util/maps_motoboy.dart';
import 'motoboy_page.dart';
import 'order_clientes.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;
final latitude = loginData.latitude;
final longitude = loginData.longitude;

class ControlPage extends StatefulWidget{

  const ControlPage({super.key});

  @override
  State<StatefulWidget> createState() => _ControlPageState();
}
class _ControlPageState extends State<ControlPage> {
  late FToast fToast;

  String? formatDate;
  late Timer _timer;



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

    var dateFormat = DateFormat('dd/MM/yyyy').format(ntpTime);

    setState(() {
      formatDate = dateFormat;
    });


  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      final bool isMobile = constraints.maxWidth < 600;

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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
          title: Text("LOJA $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: colorApp,
        ),
        backgroundColor: bck,
        body: isMobile ?
        Column(
          children: [
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10 , bottom: 15),
                  child: Text("$formatDate", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                )
            ),

            const Center(
              child: Text("LOGISTÍCA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white, fontFamily: 'SuperCell')),
            ),



            Card(
              color: Colors.transparent,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 400,
                height: 180,
                child: FutureBuilder<List>(
                  future: getMotoboy(),
                  builder: (ctx, ss) {
                    if (ss.hasError) {
                      if (kDebugMode) {
                        print(ss.error);
                      }
                    }
                    if (ss.hasData) {

                      return ItemsM(list: ss.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),

            const Padding(padding: EdgeInsets.only(top: 15) ,
                child: Center(
                    child: Text("CONFERÊNCIA ABERTURA/FECHAMENTO", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white , fontFamily: 'SuperCell')))
            ),
            Padding(padding: const EdgeInsets.only(left: 15, right: 15 , top: 15),
              child:  SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OpenPage()));

                  },
                  text: "ABERTURA",
                ),
              ),
            ),

            Padding(padding: const EdgeInsets.only(left: 15, right: 15 , top: 15),
              child:  SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ClosePage()));

                  },
                  text: "FECHAMENTO",
                ),
              ),
            ),

            const Padding(padding: EdgeInsets.only(top: 15) ,
                child: Center(
                    child: Text("AVISOS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white , fontFamily: 'SuperCell')))
            ),

            Card(
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 400,
                height: 150,
                child: FutureBuilder<List>(
                  future: getData(),
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
              ),
            ),


            Padding(padding: const EdgeInsets.only(left: 15, right: 15 , top: 30),
              child:  SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              ListTile(
                                leading: const Icon(FontAwesomeIcons.motorcycle, color: Colors.white , size: 30,),
                                title: const Text("MOTOBOY", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MotoboyPage()));


                                },
                              ),

                              ListTile(
                                leading: const Icon(FontAwesomeIcons.bagShopping, color: Colors.white , size: 30,),
                                title: const Text("SOLICITAÇÃO DE PRODUTOS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ProdutosPagePage()));

                                },
                              ),
                              ListTile(
                                leading: const Icon(FontAwesomeIcons.jugDetergent, color: Colors.white , size: 30,),
                                title: const Text("SOLICITAÇÃO DE SUPRIMENTOS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const SuprimentosPage()));


                                },
                              ),
                              ListTile(
                                leading: const Icon(FontAwesomeIcons.wrench, color: Colors.white , size: 30,),
                                title: const Text("ACOMPANHAMENTO ORDEM DE SERVIÇO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OrdemService()));

                                },
                              ),
                              ListTile(
                                leading: const Icon(FontAwesomeIcons.phone, color: Colors.white , size: 30,),
                                title: const Text("OUVIDORIA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const SacPage()));
                                },
                              ),


                              ListTile(
                                leading: const Icon(FontAwesomeIcons.storeSlash, color: Colors.white , size: 30,),
                                title: const Text("SUGESTÃO DE PRODUTOS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const SugestaoPage()));

                                },
                              ),

                              ListTile(
                                leading: const Icon(FontAwesomeIcons.clockRotateLeft, color: Colors.white , size: 30,),
                                title: const Text("ENCOMENDA DE CLIENTE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OrderClientesPage()));

                                },
                              ),


                              ListTile(
                                leading: const Icon(FontAwesomeIcons.rankingStar, color: Colors.white , size: 30,),
                                title: const Text("RANKING DESAFIO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                onTap: () {
                                  Navigator.pop(context);

                                },
                              ),
                            ],
                          );
                        });

                  },
                  text: "ABRIR MENU",
                ),
              ),
            ),

          ],
        ) :

        Stack(
          children: [
            Column(
              children: [
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10 , bottom: 15),
                      child: Text("$formatDate", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                    )
                ),

                const Center(
                  child: Text("LOGISTÍCA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white, fontFamily: 'SuperCell')),
                ),

              Padding(
                  padding: const EdgeInsets.only(left: 220, right: 120),
                  child:   Card(
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 80),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: FutureBuilder<List>(
                    future: getMotoboy(),
                    builder: (ctx, ss) {
                      if (ss.hasError) {
                        if (kDebugMode) {
                          print(ss.error);
                        }
                      }
                      if (ss.hasData) {

                        return ItemsM(list: ss.data!);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
              ),

                const Padding(padding: EdgeInsets.only(top: 15) ,
                    child: Center(
                        child: Text("CONFERÊNCIA ABERTURA/FECHAMENTO", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white , fontFamily: 'SuperCell')))
                ),

                Padding(padding: const EdgeInsets.only(left: 15, right: 15 , top: 15),
                  child:  SizedBox(
                    width: 450,
                    height: 50,
                    child: CustomButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OpenPage()));

                      },
                      text: "ABERTURA",
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.only(left: 15, right: 15 , top: 15),
                  child:  SizedBox(
                    width: 450,
                    height: 50,
                    child: CustomButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ClosePage()));

                      },
                      text: "FECHAMENTO",
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(top: 15) ,
                    child: Center(
                        child: Text("AVISOS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white , fontFamily: 'SuperCell')))
                ),

                Padding(padding: const EdgeInsets.only(left: 300, right: 120),
                child:   Card(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: FutureBuilder<List>(
                      future: getData(),
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
                  ),
                )),
              ],
            ),

            Positioned(
                top: 10,
                bottom: 30,
                left: 30,
                child:SizedBox(
                  width: 250,
                  height: 50,
                  child: Column(
                    children: [

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MotoboyPage()));
                            },
                            text: "MOTOBOY             " ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ProdutosPagePage()));

                            },
                            text: "SOLICITAR PRODUTOS" ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const SuprimentosPage()));

                            },
                            text: "SOLICITAR SUPRIMENTOS" ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OrdemService()));

                            },
                            text: "ORDEM DE SERVIÇO" ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const SacPage()));

                            },
                            text: "OUVIDORIA             " ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const SugestaoPage()));

                            },
                            text: "SUGESTÃO DE PRODUTOS" ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OrderClientesPage()));

                            },
                            text: "ENCOMENDA DE CLIENTE" ,
                          ),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 40),
                        child:  SizedBox(
                          child: CustomButton(
                            onPressed: ()  {
                            },
                            text: "RANKING DESAFIO" ,
                          ),
                        ),
                      ),
                    ],
                  )
                )
            ),

          ],
        )


      );
    });


  }


}

// ignore: must_be_immutable
class Items extends StatelessWidget {

  List list;

  Items({super.key,  required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (ctx,i){
          return Card(
            color: Colors.red[300],
            margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
                child: ListTile(
                  title: Text("${list[i]['data']}: ${list[i]['mensagem']} ",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                    overflow: TextOverflow.clip,
                  ),
                )
            ),
          );
        }
    );
  }
}

// ignore: must_be_immutable
class ItemsM extends StatelessWidget {
  List list;

  ItemsM({super.key,  required this.list});

   FToast? fToast;

  @override
  Widget build(BuildContext context) {


    fToast = FToast();
    fToast?.init(context);

    return ListView.builder(
      // This next line does the trick.
        scrollDirection: Axis.horizontal,

        itemCount: list.length,
        itemBuilder: (ctx,i){
          return SizedBox(
              width: 310,
              child: Card(
                color: Colors.black,
                elevation: 15,
                margin: const EdgeInsets.only(left: 10, right: 10 , top: 15, bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: SizedBox(
                    child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Padding(padding: EdgeInsets.only(left: 15,right: 15),
                                  child:Icon(FontAwesomeIcons.motorcycle , color: Colors.white),
                                ),
                                Text("${list[i]['motoboy']} ",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white),
                                  overflow: TextOverflow.clip,
                                ),

                                const Padding(padding: EdgeInsets.only(left: 10,right: 15),
                                  child:Icon(FontAwesomeIcons.motorcycle , color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    const Text("CHEGOU DE: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white, fontFamily: 'SuperCell')),
                                    Text("${list[i]['local_last']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                                  ]
                              ),
                              const SizedBox(height: 3),
                              Row(
                                  children: [
                                    const Text("HORÁRIO: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white, fontFamily: 'SuperCell')),
                                    Text("${list[i]['dataC']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                  ]
                              ),
                              const SizedBox(height: 3),
                              Row(
                                  children: [
                                    const Text("DESTINO: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white, fontFamily: 'SuperCell')),
                                    Text("${list[i]['local_next']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                                  ]
                              ),
                              const SizedBox(height: 3),
                              Row(
                                  children: [
                                    const Text("HORÁRIO: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white, fontFamily: 'SuperCell')),
                                    Text("${list[i]['dataS']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                                  ]
                              ),
                            ],
                          ),
                        ),
                        onTap: () => kIsWeb ? _showToastCancel("FUNÇÃO DISPONÍVEL APENAS PARA MOBILE") : Navigator.push(context, MaterialPageRoute(builder: (builder)=> MapsMotoboy(latnow:latitude , longnow: longitude, latnext: list[i]['lat_next'], longnext: list[i]['long_next'])))

                    )
                ),
              )
          );
        }
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text("$msg", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold , color: Colors.white , fontFamily: 'SuperCell')),
          ),
        ],
      ),
    );
    fToast?.showToast(
      child: toastWithButton,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }


}



