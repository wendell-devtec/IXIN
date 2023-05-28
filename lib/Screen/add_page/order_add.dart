import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ixin/Screen/control_page.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;

import '../../util/common.dart';
import '../../util/custom_button.dart';
import '../../util/text_field.dart';

final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;

class OrderAddPage extends StatefulWidget{
  const OrderAddPage({super.key});



  @override
  State<StatefulWidget> createState() => _OrderAddPagePageState();



}

class _OrderAddPagePageState extends State<OrderAddPage> {
  late FToast fToast;
  bool sinalCheck = false;
  bool sinalCheck1 = false;
  String? formatDate;
  String? status = "Pendente";
  int? valor = 0;

  String? _seller;
  final produtoControl = TextEditingController();
  final obsControl = TextEditingController();

  final _textController = TextEditingController();

  late GlobalKey<ArtDialogState> _artDialogKey;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
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
    _artDialogKey =  GlobalKey<ArtDialogState>();
    fToast = FToast();
    fToast.init(context);

    getSeller().then((items) {
      setState(() {
        _items = items.cast<Map<String, dynamic>>();
      });
    });

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
    Color colorApp;
    Color bck;

    if(kIsWeb){
      colorApp = Colors.black54;
      bck = Colors.black38;

    }else{
      colorApp = Theme.of(context).colorScheme.primary;
      bck = colorApp;

    }

    void addData(){


      const  url = "https://devtecapps.com.br/ixin/addOrder.php";
      final uri = Uri.tryParse(url);

      http.post(uri!,body: {
        "nomeP": produtoControl.text.trim(),
        "loja": storeName,
        "vendedor": _seller,
        "data": formatDate,
        "status": status,
        "sinal": "$sinalCheck",
        "valor_sinal": "$valor",
        "obs": obsControl.text.trim()

      }).then((value) {
        String msg = "REGISTRO DE ENCOMENDA CONCLUIDO";
        _showToastCancel(msg);
      });
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ENCOMENDAR PRODUTO", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 16, fontWeight: FontWeight.bold),),
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

      body: Flex(direction: Axis.vertical,

        children: [
          Column(
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

                      Row(
                        children: const [
                          Padding(padding: EdgeInsets.only(left: 15 , top: 15),
                            child:Text("DIGITE O PRODUTO A SER ENCOMENDADO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                          )

                        ],
                      ),
                      Card(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            cursorColor: Colors.white,
                            controller: produtoControl,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                  r'[\u{1F3FB}-\u{1F3FF}|\u{1F1E6}-\u{1F1FF}|[\u{1F170}-\u{1F9FF}]'
                                  r'[\u{1F600}-\u{1F64F}'
                                  r'|\u{1F300}-\u{1F5FF}'
                                  r'|\u{1F680}-\u{1F6FF}'
                                  r'|\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
                                  unicode: true,
                                  dotAll: true,
                                ),
                              ),
                            ],

                            decoration: InputDecoration(
                              prefixIcon: Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.productHunt,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              hintText: "EX: SSD 1Tb",
                              hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),

                            ),

                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          setState(() {
                            sinalCheck = !sinalCheck;
                            if (sinalCheck) {
                              _checkSinal();
                            }
                          });
                        },
                        child: Card(
                          color: Colors.transparent,
                          margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              children:  [
                                const Padding(padding: EdgeInsets.only(left: 15),
                                  child:Text("SINAL", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: sinalCheck,

                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          sinalCheck = newValue!;
                                          sinalCheck1 = false;
                                          if (sinalCheck) {
                                            _checkSinal();
                                          }
                                        });
                                      },
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,

                                    ),
                                    const Text("SIM: ",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20)),

                                    Checkbox(
                                      value: sinalCheck1,
                                      onChanged: (bool? newValue) {
                                        setState(() async {
                                          sinalCheck1 = newValue!;
                                          if (sinalCheck1) {
                                            await ArtSweetAlert.show(
                                                barrierDismissible: false,
                                                artDialogKey: _artDialogKey,
                                                context: context,
                                                artDialogArgs: ArtDialogArgs(
                                                  title: "OPS! VOCÊ PRECISA PEGAR SINAL",
                                                  text: "TODAS AS ENCOMENDAS SÓ SÃO PROCESSADAS APÓS O SINAL DE 50% DO PRODUTO",

                                                  onConfirm: () async  {
                                                    _artDialogKey.currentState?.closeDialog();

                                                  },


                                                  onDeny: (){
                                                    _artDialogKey.currentState?.closeDialog();
                                                    setState(() {
                                                      sinalCheck = false;
                                                    });

                                                  },

                                                  onDispose: () {
                                                    _artDialogKey = GlobalKey<ArtDialogState>();
                                                  },
                                                )
                                            );
                                          }
                                        });
                                      },
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                    ),

                                    const Text("NÃO",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20)),

                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),

                      Card(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children:  [
                              Padding(padding: const EdgeInsets.only(left: 15),
                                child:Text("VALOR SINAL: R\$ $valor", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                              )

                            ],
                          ),
                        ),
                      ),


                      Card(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(left: 10, right: 10 , top: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: DropdownSearch(

                          popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: false,
                              searchDelay: Duration(milliseconds: 5),

                              searchFieldProps: TextFieldProps(
                                cursorColor: Colors.white,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),

                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.redAccent),

                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.redAccent )
                                    ),
                                    hintText: "PESQUISE SEU NOME",
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                    suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                    suffixIconColor: Colors.white
                                ),
                              ) ,


                              menuProps: MenuProps(
                                backgroundColor: Colors.blue,

                              )
                          ),
                          items: _items,

                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                            dropdownSearchDecoration: InputDecoration(
                                labelText: "SELECIONE SEU NOME",
                                labelStyle:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                                suffixIconColor: Colors.white,
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                )
                            ),

                          ),
                          onChanged: (value) {

                            setState(() {
                              _items.remove(value);
                              _items.insert(0, value!);
                              _seller = _items.isNotEmpty ? '${_items[0]['numero'] as String} ${_items[0]['nome'] as String}' : '';
                            });

                          },

                          itemAsString: (item) => "${item!['numero']} - ${item['nome']}",
                        )
                      ),



                      Row(
                        children: const [
                          Padding(padding: EdgeInsets.only(left: 15 , top: 15),
                            child:Text("DIGITE OBS CASO NESCESSÁRIO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                          )

                        ],
                      ),
                      Card(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            cursorColor: Colors.white,
                            controller: obsControl,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                  r'[\u{1F3FB}-\u{1F3FF}|\u{1F1E6}-\u{1F1FF}|[\u{1F170}-\u{1F9FF}]'
                                  r'[\u{1F600}-\u{1F64F}'
                                  r'|\u{1F300}-\u{1F5FF}'
                                  r'|\u{1F680}-\u{1F6FF}'
                                  r'|\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
                                  unicode: true,
                                  dotAll: true,
                                ),
                              ),
                            ],

                            decoration: InputDecoration(
                              prefixIcon: Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.signature,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              hintText: "EX: PELICULA MOTO G 90 DE ALUMINIO",
                              hintStyle: const TextStyle(fontSize: 16.0, color: Colors.white),

                            ),

                          ),
                        ),
                      ),


                      Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child:  SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                            onPressed: () async {
                              if(sinalCheck1){
                                await ArtSweetAlert.show(
                                    barrierDismissible: false,
                                    artDialogKey: _artDialogKey,
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                      title: "OPS! VOCÊ PRECISA PEGAR SINAL",
                                      text: "TODAS AS ENCOMENDAS SÓ SÃO PROCESSADAS APÓS O SINAL DE 50% DO PRODUTO",

                                      onConfirm: () async  {
                                        _artDialogKey.currentState?.closeDialog();

                                      },


                                      onDeny: (){
                                        _artDialogKey.currentState?.closeDialog();
                                        setState(() {
                                          sinalCheck = false;
                                        });

                                      },

                                      onDispose: () {
                                        _artDialogKey = GlobalKey<ArtDialogState>();
                                      },
                                    )
                                );
                                return;
                              }
                              if(produtoControl.text.isEmpty & _textController.text.isEmpty){
                                var msg = "DIGITE OS CAMPOS EM BRANCO!!";
                                _showToastCancel(msg);
                                return;
                              }
                              addData();


                            },
                            text: "SOLICITAR",
                          ),
                        ),
                      )


                    ]
                ),
              )
            ],
          ),
        ],

      )
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


  _checkSinal() async {
      await ArtSweetAlert.show(
          barrierDismissible: false,
          artDialogKey: _artDialogKey,
          context: context,
          artDialogArgs: ArtDialogArgs(
            denyButtonText: "Sair",
            title: "DIGITAR VALOR SINAL:",
            customColumns: [
              Container(
                margin: const EdgeInsets.only( bottom: 20.0 ),
                child:  textField(
                  hintText: "580",
                  icon: FontAwesomeIcons.moneyBillTransfer,
                  inputType: TextInputType.text,
                  maxLines: 1,
                  controller: _textController,
                  maxLength: 10,
                ),
              )
            ],
            onConfirm: () async  {
              _artDialogKey.currentState?.showLoader();
              setState(() {
                valor = int.parse(_textController.text);

              });
              _artDialogKey.currentState?.hideLoader();
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



