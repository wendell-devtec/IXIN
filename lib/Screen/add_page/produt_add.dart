import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;

import '../../util/custom_button.dart';
import '../control_page.dart';
import '../../util/common.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;

class ProductAddPage extends StatefulWidget{
  const ProductAddPage({super.key});



  @override
  State<StatefulWidget> createState() => _ProductAddPagePageState();



}

class _ProductAddPagePageState extends State<ProductAddPage> {
  late FToast fToast;

  String? formatDate;
  String? status = "AGUARDANDO SETOR";
  String? seller;


  final sellerControl = TextEditingController();
  final qtdControl = TextEditingController();


  String? _selectedOption ;
  String? _selectedCode ;
  String? selectedValue;

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _itemsS = [];




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
    fToast = FToast();
    fToast.init(context);

    getProdutos().then((items) {
      setState(() {
        _items = items.cast<Map<String, dynamic>>();
      });
    });

    getSeller().then((items) {
      setState(() {
        _itemsS = items.cast<Map<String, dynamic>>();
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

  void addData(){


    const  url = "https://devtecapps.com.br/ixin/addP.php";
    final uri = Uri.tryParse(url);

    http.post(uri!,body: {
      "loja": storeName,
      "nomeP" : _selectedOption,
      "code": _selectedCode,
      "qtd": qtdControl.text,
      "vendedor": seller,
      "status": status,
      "data": formatDate,
      "obs": sellerControl.text.trim()

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
        title: const Text("SOLICITAR PRODUTO", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 16, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colorApp,
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

                    Card(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(left: 10, right: 10 , bottom: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                          child:  Column(
                            children: [
                              DropdownSearch(

                                popupProps: const PopupProps.bottomSheet(
                                    showSearchBox: true,
                                    showSelectedItems: false,
                                    searchDelay: Duration(milliseconds: 5),

                                    searchFieldProps: TextFieldProps(
                                      cursorColor: Colors.white,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),

                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),

                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          hintText: "PESQUISE SEU NOME",
                                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                          suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                          suffixIconColor: Colors.white
                                      ),
                                    ) ,


                                    bottomSheetProps: BottomSheetProps(
                                      enableDrag: true,
                                      backgroundColor: Colors.blue,

                                    )
                                ),
                                items: _itemsS,

                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "SELECIONAR VENDEDOR",
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
                                    seller = _itemsS.isNotEmpty ? '${_itemsS[0]['numero'] as String} ${_itemsS[0]['nome'] as String}' : '';

                                  });

                                },

                                itemAsString: (item) => "${item!['numero']} - ${item['nome']}",
                              )
                            ],
                          )
                      ),
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
                                showSearchBox: true,
                                showSelectedItems: false,
                                  searchDelay: Duration(milliseconds: 5),

                                searchFieldProps: TextFieldProps(
                                  cursorColor: Colors.white,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),

                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),

                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  hintText: "PESQUISE PELOS PRODUTOS",
                                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                      suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                      suffixIconColor: Colors.white
                                  ),
                                ) ,


                                bottomSheetProps: BottomSheetProps(
                                  enableDrag: true,
                                  backgroundColor: Colors.blue,

                                )
                              ),
                              items: _items,

                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "SELECIONE OS PRODUTOS",
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
                                  _selectedOption = _items.isNotEmpty? _items[0]['nome'] as String : '';
                                  _selectedCode = _items.isNotEmpty? _items[0]['code'] as String : '';
                                });

                              },

                              itemAsString: (item) => "${item!['code']} - ${item['nome']}",
                            )
                          ],
                        )
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
                                child:Text("PRODUTO: $_selectedOption", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                              )

                            ],
                          ),
                      ),
                    ),

                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.only(left: 15 , top: 15),
                          child:Text("QUANTIDADE EM LOJA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
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
                          controller: qtdControl,
                          keyboardType: TextInputType.number,
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
                            hintText: "EX: 4",
                            hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),

                          ),

                        ),
                      ),
                    ),

                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.only(left: 15 , top: 15),
                          child:Text("Obs:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white)),
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
                          controller: sellerControl,
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
                            hintText: "EX: Preciso de 50 unidades sai muito",
                            hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),

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
                            String msg = "ESCOLHA UM PRODUTO PARA PROSSEGUIR";

                            if(_selectedOption == null){
                              _showToastCancel(msg);
                              return;
                            }
                            if(qtdControl.text.isEmpty){
                              String msg = "DIGITE A QUANTIDADE EM LOJA POR FAVOR";
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






