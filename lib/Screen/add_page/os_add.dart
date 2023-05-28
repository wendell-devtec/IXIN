import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../util/custom_button.dart';
import '../control_page.dart';
import '../../util/common.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;

class OsAddPage extends StatefulWidget{
  const OsAddPage({super.key});



  @override
  State<StatefulWidget> createState() => _OsAddPageState();



}

class _OsAddPageState extends State<OsAddPage> {
  late FToast fToast;

  String? formatDate;
  String? status = "AGUARDANDO";
  String? _seller;
  String? _selectedOs;
  String osnext = '';



  final sellerControl = TextEditingController();
  final qtdControl = TextEditingController();





  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _itemsOs = [];
  List<Map<String, dynamic>> _itemsNOs = [];



  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    getSeller().then((items) {
      setState(() {
        _items = items.cast<Map<String, dynamic>>();
      });
    });

    getTypeOs().then((items) {
      setState(() {
        _itemsOs = items.cast<Map<String, dynamic>>();
      });
    });

    getOsLimit(int.parse(storeName)).then((items) {
      setState(() {
        _itemsNOs = items.cast<Map<String, dynamic>>();
        var osnumber = (_itemsNOs.isNotEmpty? _itemsNOs[0]['os_number'] : '');
        var ossum = int.parse(osnumber) + 1;
        osnext = ossum.toString();
      });
    });

  }


  void addData(){


    const  url = "https://devtecapps.com.br/ixin/addOs.php";
    final uri = Uri.tryParse(url);

    http.post(uri!,body: {
      "loja": storeName,
      "data": formatDate,
      "produto": _selectedOs,
      "os_number": osnext,
      "vendedor": _seller,
      "status": status

    }).then((value) {
      String msg = "REGISTRO DE SOLICITAÇÃO DE PRODUTO CONCLUIDO";
      _showToastCancel(msg);
    });
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ADD OS $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 18, fontWeight: FontWeight.bold),),
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
                            child: Center(
                              child: Icon(FontAwesomeIcons.mobileScreenButton, color: Colors.white, size: 50)
                            )
                        ),

                      ],
                    )
                )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                  children: [

                    Card(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        child:  Column(
                          children: [
                            DropdownSearch(

                              popupProps: const PopupProps.bottomSheet(
                                showSelectedItems: false,
                                bottomSheetProps: BottomSheetProps(
                                  enableDrag: true,
                                  backgroundColor: Colors.blue,
                                )
                              ),
                              items: _items,

                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "SELECIONE SEU NOME E NÚMERO",
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
                                  _seller = _items.isNotEmpty ? '${_items[0]['numero'] as String} -  ${_items[0]['nome'] as String}' : '';
                                });

                              },

                              itemAsString: (item) => "${item!['numero']} - ${item['nome']}",

                            )
                          ],
                        )
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Card(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                          child:  Column(
                            children: [
                              DropdownSearch(

                                popupProps: const PopupProps.bottomSheet(
                                    bottomSheetProps: BottomSheetProps(
                                      enableDrag: true,
                                      backgroundColor: Colors.blue,

                                    )
                                ),
                                items: _itemsOs,

                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "SELECIONE TIPO DE APARELHO",
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
                                    _itemsOs.remove(value);
                                    _itemsOs.insert(0, value!);
                                    _selectedOs = _itemsOs.isNotEmpty? _itemsOs[0]['produto'] as String : '';
                                  });

                                },

                                itemAsString: (item) => "- ${item['produto']}",
                              )
                            ],
                          )
                      ),
                    ),

                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.only(left: 15 , top: 15),
                          child:Text("PRÓXIMO NÚMERO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
                        )

                      ],
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
                              child:Text("OS: $osnext", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                            )

                          ],
                        ),
                      ),
                    ),




                    Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child:  SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {

                            if(kIsWeb){
                              DateTime now = DateTime.now();
                              var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);


                              setState(() {
                                formatDate = dateFormat;
                              });

                            }else{
                              DateTime? currentTime = await getCurrentTime();
                              var dateFormat  = DateFormat('dd/MM/yyyy HH:mm:ss').format(currentTime!);
                              formatDate = dateFormat;
                            }

                            var msg = "VOCÊ NÃO SELECIONOU SEU NOME!!";

                            if(_seller == null){
                              _showToastCancel(msg);
                              return;
                            }

                            if(_selectedOs == null){
                              var msg = "SELECIONE O TIPO DE APARELHO";
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

}






