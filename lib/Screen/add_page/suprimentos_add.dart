import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class SuprimentosAddPage extends StatefulWidget{
  const SuprimentosAddPage({super.key});



  @override
  State<StatefulWidget> createState() => _SuprimentosAddPageState();



}

class _SuprimentosAddPageState extends State<SuprimentosAddPage> {
  String? formatDate;
  String? status = "AGUARDANDO SETOR";
  late FToast fToast;




  String? _selectedOption ;

  Future<List> getData() async {
    final response =
    await http.get(Uri.parse('https://devtecapps.com.br/ixin/getSuprimento.php'));
    return json.decode(response.body);
  }

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

    fToast = FToast();
    fToast.init(context);


    getData().then((items) {
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

  void addData(){


    const  url = "https://devtecapps.com.br/ixin/addS.php";
    final uri = Uri.tryParse(url);

    http.post(uri!,body: {
      "loja": storeName,
      "nomeS" : _selectedOption,
      "status": status,
      "data": formatDate,

    }).then((value) {
      String msg = "REGISTRO DE SOLICITAÇÃO DE SUPRIMENTOS CONCLUIDO , JÁ PODE VOLTAR AO INÍCIO";
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
        title: const Text("SOLICITAR SUPRIMENTOS", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 14, fontWeight: FontWeight.bold),),
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
                            child: Icon(FontAwesomeIcons.sprayCan, color: Colors.white,)
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
                            const SizedBox(
                              height: 15,
                            ),
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
                                  hintText: "PESQUISE PELOS SUPRIMENTOS DESEJADOS",
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
                                  _selectedOption = _items.isNotEmpty? _items[0]['nomeS'] as String : '';
                                });

                              },

                              itemAsString: (item) => "${item['nomeS']}",
                            )
                          ],
                        )
                      ),
                    ),

                    Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child:  SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            if(_selectedOption == null){
                              var msg = "VOCÊ NÃO SELECIONOU O SUPRIMENTO!!";
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






