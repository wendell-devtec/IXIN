import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;

import '../../../util/common.dart';
import '../../../util/custom_button.dart';
import '../../../util/text_field.dart';
import 'control_page.dart';

final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;
final latitude = loginData.latitude;
final longitude = loginData.longitude;

class MotoboyPage extends StatefulWidget{

  const MotoboyPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateMotoboyPage();
}

class _StateMotoboyPage extends State<MotoboyPage>{
  late FToast fToast;
  String? formatDate;
  late GlobalKey<ArtDialogState> _artDialogKey;
  GroupController controller = GroupController();

  final _textController = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();



  String? _seller;
  String? _store;
  String? _storeN;

  String? __os;
  String? __osL;
  String _os = '';
  String _osL = '';

  String? _pr;
  String? _prL;

  String? _tr;
  String? _trL;

  String? _ml;
  String? _mlL;


  String? _ot;
  String? __otL;

  String outrosS = '' ;
  String outrosLS = '' ;
  String? _motoboy ;

  String? formatDate2;
  String? lat;
  String? long;

  String distanceInMeters = '';

  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> _itemsS = [];

  List<Map<String, dynamic>> _itemsM = [];


  @override
  void initState() {
    if(kIsWeb){
      DateTime now = DateTime.now();
      var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);


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

    getStore().then((items) {
      setState(() {
        _itemsS = items.cast<Map<String, dynamic>>();
      });
    });

    getMotoboyName().then((items) {
      setState(() {
        _itemsM = items.cast<Map<String, dynamic>>();
      });
    });

  }
  Future<DateTime?> getCurrentTime() async {
    DateTime? currentTime;
    try {
      currentTime = await NTP.now();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return currentTime;
  }

  Future<void> _checkTime() async {
    DateTime ntpTime;


    ntpTime = await NTP.now();

    var dateFormat  = DateFormat('dd/MM/yyyy HH:mm:ss').format(ntpTime);

    setState(() {
      formatDate = dateFormat;
    });

    return;
  }

  void addData(){


    const  url = "https://devtecapps.com.br/ixin/addMt.php";
    final uri = Uri.tryParse(url);

    http.post(uri!,body: {
      "dataC" : formatDate,
      "dataS": formatDate2,
      "local_last": _store,
      "local_next": _storeN,
      "loja": storeName,
      "nome": _seller,
      "motoboy": _motoboy,
      "produtos": _pr,
      "malote": _ml,
      "troco": _tr,
      "os": _os,
      "outros": outrosS,
      "produtosL": _prL,
      "maloteL": _mlL,
      "trocoL": _trL,
      "osL": _osL,
      "outrosL": outrosLS,
      "lat_now": latitude,
      "long_now": longitude,
      "lat_next": lat,
      "long_next": long,
      "distancia": distanceInMeters
    }).then((value) {
      String msg = "REGISTRO DE MOTOBOY CONCLUIDO";
      _showToastCancel(msg);
      _homeRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

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
            title: const Text("ADCIONAR MOTOBOY", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
            centerTitle: true,
            backgroundColor: colorApp,
          ),
          backgroundColor: bck,

          body: isMobile ? SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 5, top: 15),
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
                                    hintText: "PESQUISE PELO MOTOBOY",
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                    suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                    suffixIconColor: Colors.white
                                ),
                              ) ,


                              menuProps: MenuProps(
                                backgroundColor: Colors.blue,

                              )
                          ),
                          items: _itemsM,

                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                            dropdownSearchDecoration: InputDecoration(
                                labelText: "SELECIONE O MOTOBOY",
                                labelStyle:  TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white),
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
                              _itemsM.remove(value);
                              _itemsM.insert(0, value!);
                              _motoboy = _itemsM.isNotEmpty ? _itemsM[0]['nome'] as String : '';
                            });

                          },

                          itemAsString: (item) => "${item['nome']}",
                        )
                    ),
                    const Divider(),

                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 15),
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
                    const Divider(),

                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 15),
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
                                    hintText: "PESQUISE PELO LOCAL",
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                    suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                    suffixIconColor: Colors.white
                                ),
                              ) ,


                              menuProps: MenuProps(
                                backgroundColor: Colors.blue,

                              )
                          ),
                          items: _itemsS,

                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                            dropdownSearchDecoration: InputDecoration(
                                labelText: "SELECIONE O ULTIMO LOCAL DO MOTOBOY",
                                labelStyle:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
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
                              _itemsS.remove(value);
                              _itemsS.insert(0, value!);
                              _store = _itemsS.isNotEmpty ? _itemsS[0]['nome'] as String : '';
                            });

                          },

                          itemAsString: (item) => "${item['nome']}",
                        )
                    ),

                    Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text("TROUXE OS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 19)),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  __os = values;
                                });

                                if(__os == "SIM"){
                                  _checkInfo4();
                                }



                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Center(
                              child: Text("TROUXE PRODUTOS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _pr = values;

                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Center(
                              child: Text("TROUXE TROCO?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _tr = values;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            const Center(
                              child: Text("TROXE MALOTE?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _ml = values;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text("TROUXE OUTROS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _ot = values;
                                });

                                if(_ot == "SIM"){
                                  _checkInfo();
                                }
                              },
                            ),
                          ],
                        ),


                        Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 5, top: 15),
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
                                        hintText: "PESQUISE PELO LOCAL",
                                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                        suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                        suffixIconColor: Colors.white
                                    ),
                                  ) ,


                                  menuProps: MenuProps(
                                    backgroundColor: Colors.blue,

                                  )
                              ),
                              items: _itemsS,

                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "SELECIONE O PROXIMO LOCAL DO MOTOBOY",
                                    labelStyle:  TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white),
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
                                  _itemsS.remove(value);
                                  _itemsS.insert(0, value!);
                                  _storeN = _itemsS.isNotEmpty ? _itemsS[0]['nome'] as String : '';
                                  lat = _itemsS.isNotEmpty ? _itemsS[0]['latitude'] : '';
                                  long = _itemsS.isNotEmpty ? _itemsS[0]['longitude'] : '';

                                });

                              },

                              itemAsString: (item) => "${item['nome']}",
                            )
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text("LEVOU OS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18)),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  __osL = values;
                                });

                                if(__osL == "SIM"){
                                  _checkInfo3();
                                }
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Center(
                              child: Text("LEVOU PRODUTOS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize:18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _prL = values;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Center(
                              child: Text("LEVOU TROCO?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize:18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _trL = values;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Center(
                              child: Text("LEVOU MALOTE?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  _mlL = values;
                                });
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Center(
                              child: Text("LEVOU OUTROS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                overflow: TextOverflow.fade,),
                            ),
                            SimpleGroupedChips<String>(
                              controller: controller,
                              values: const ["SIM" , "NÃO"],
                              itemTitle: const ["SIM" ,"NÃO"],
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: Colors.red[400],
                                textColor: Colors.white,
                                itemTitleStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onItemSelected: (values) {
                                setState(() {
                                  __otL = values;
                                });

                                if(__otL == "SIM"){
                                  _checkInfo2();
                                }
                              },
                            ),
                          ],
                        ),

                      ],
                    ),

                    Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                      child:  SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            DateTime? currentTime = await getCurrentTime();
                            var dateFormat  = DateFormat('dd/MM/yyyy HH:mm:ss').format(currentTime!);
                            formatDate2 = dateFormat;
                            var msg = "VOCÊ NÃO SELECIONOU SEU NOME!!";
                            if(_motoboy == null){
                              var msg = "SELECIONE O MOTOBOY PARA CONTINUAR";
                              _showToastCancel(msg);
                              return;
                            }

                            if(_seller == null){
                              _showToastCancel(msg);
                              return;
                            }
                            if(_store == null || _storeN == null){
                              var msg = "SELECIONE OS LOCAIS PARA PROSSEGUIR";
                              _showToastCancel(msg);
                              return;
                            }

                            if(_pr == null || _prL == null
                                || _tr == null || _trL == null || _ml == null || _mlL == null){
                              var msg = "SELECIONE UMA DAS OPÇÕES PARA PROSSEGUIR";
                              _showToastCancel(msg);
                              return;

                            }
                            _calculateDistance();


                          },
                          text: "SALVAR",
                        ),
                      ),
                    )


                  ]
              ),
            ),
          ) : SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 500,
                      child:  Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 5, top: 15),
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
                                        borderSide: BorderSide(color: Colors.white),

                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white )
                                      ),
                                      hintText: "PESQUISE PELO MOTOBOY",
                                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                      suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                      suffixIconColor: Colors.white
                                  ),
                                ) ,


                                menuProps: MenuProps(
                                  backgroundColor: Colors.black45,

                                )
                            ),
                            items: _itemsM,

                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "SELECIONE O MOTOBOY",
                                  labelStyle:  TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white),
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
                                _itemsM.remove(value);
                                _itemsM.insert(0, value!);
                                _motoboy = _itemsM.isNotEmpty ? _itemsM[0]['nome'] as String : '';
                              });

                            },

                            itemAsString: (item) => "${item['nome']}",
                          )
                      )
                    ),

                    const Divider(),
                    SizedBox(
                        height: 80,
                        width: 500,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 15),
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
                                          borderSide: BorderSide(color: Colors.white),

                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white )
                                        ),
                                        hintText: "PESQUISE SEU NOME",
                                        hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                                        suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                        suffixIconColor: Colors.white
                                    ),
                                  ) ,


                                  menuProps: MenuProps(
                                    backgroundColor: Colors.black45,

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
                        )
                    ),

                    const Divider(),

                    SizedBox(
                        height: 80,
                        width: 500,
                        child:        Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 15),
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
                                          borderSide: BorderSide(color: Colors.white),

                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white )
                                        ),
                                        hintText: "PESQUISE PELO LOCAL",
                                        hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                                        suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                        suffixIconColor: Colors.white
                                    ),
                                  ) ,


                                  menuProps: MenuProps(
                                    backgroundColor: Colors.black45,

                                  )
                              ),
                              items: _itemsS,

                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "SELECIONE O ULTIMO LOCAL DO MOTOBOY",
                                    labelStyle:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
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
                                  _itemsS.remove(value);
                                  _itemsS.insert(0, value!);
                                  _store = _itemsS.isNotEmpty ? _itemsS[0]['nome'] as String : '';
                                });

                              },

                              itemAsString: (item) => "${item['nome']}",
                            )
                        )
                    ),

                    const Divider(),

                    Column(
                      children: [

                        Padding(padding: const EdgeInsets.only(top: 15),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text("TROUXE OS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 19)),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    __os = values;
                                  });

                                  if(__os == "SIM"){
                                    _checkInfo4();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top: 15),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("TROUXE PRODUTOS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _pr = values;

                                  });
                                },
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top: 15),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("TROUXE TROCO?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _tr = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              const Center(
                                child: Text("TROXE MALOTE?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _ml = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text("TROUXE OUTROS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _ot = values;
                                  });

                                  if(_ot == "SIM"){
                                    _checkInfo();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),


                        SizedBox(
                          height: 80,
                          width: 500,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 5, top: 15),
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
                                            borderSide: BorderSide(color: Colors.white),

                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white )
                                          ),
                                          hintText: "PESQUISE PELO LOCAL",
                                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                          suffixIcon: Icon(FontAwesomeIcons.searchengin),
                                          suffixIconColor: Colors.white
                                      ),
                                    ) ,


                                    menuProps: MenuProps(
                                      backgroundColor: Colors.black45,

                                    )
                                ),
                                items: _itemsS,

                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  baseStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "SELECIONE O PROXIMO LOCAL DO MOTOBOY",
                                      labelStyle:  TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white),
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
                                    _itemsS.remove(value);
                                    _itemsS.insert(0, value!);
                                    _storeN = _itemsS.isNotEmpty ? _itemsS[0]['nome'] as String : '';
                                    lat = _itemsS.isNotEmpty ? _itemsS[0]['latitude'] : '';
                                    long = _itemsS.isNotEmpty ? _itemsS[0]['longitude'] : '';

                                  });

                                },

                                itemAsString: (item) => "${item['nome']}",
                              )
                          ),
                        ),



                        Padding(padding: const EdgeInsets.only(top: 15),
                          child:   Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text("LEVOU OS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18)),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    __osL = values;
                                  });

                                  if(__osL == "SIM"){
                                    _checkInfo3();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("LEVOU PRODUTOS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize:18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _prL = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("LEVOU TROCO?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize:18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _trL = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("LEVOU MALOTE?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    _mlL = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(top: 15),
                          child:    Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("LEVOU OUTROS?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
                                  overflow: TextOverflow.fade,),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    __otL = values;
                                  });

                                  if(__otL == "SIM"){
                                    _checkInfo2();
                                  }
                                },
                              ),
                            ],
                          ),
                        )


                      ],
                    ),
                    const Divider(),

                    Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                      child:  SizedBox(
                        width: 150,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            if(kIsWeb){
                              DateTime now = DateTime.now();
                              var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
                              formatDate2 = dateFormat;
                            }else{
                              DateTime? currentTime = await getCurrentTime();
                              var dateFormat  = DateFormat('dd/MM/yyyy HH:mm:ss').format(currentTime!);
                              formatDate2 = dateFormat;
                            }

                            var msg = "VOCÊ NÃO SELECIONOU O MOTOBOY!!";
                            if(_motoboy == null){
                              var msg = "SELECIONE O MOTOBOY PARA CONTINUAR";
                              _showToastCancel(msg);
                              return;
                            }

                            if(_seller == null){
                              _showToastCancel(msg);
                              return;
                            }
                            if(_store == null || _storeN == null){
                              var msg = "SELECIONE OS LOCAIS PARA PROSSEGUIR";
                              _showToastCancel(msg);
                              return;
                            }

                            if(_pr == null || _prL == null
                                || _tr == null || _trL == null || _ml == null || _mlL == null){
                              var msg = "SELECIONE UMA DAS OPÇÕES PARA PROSSEGUIR";
                              _showToastCancel(msg);
                              return;

                            }
                            _calculateDistance();


                          },
                          text: "SALVAR",
                        ),
                      ),
                    )






                  ]
              ),
            ),
          )
      );

    });
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

  void _homeRoute() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const ControlPage()));

  }

  void _calculateDistance() async {
    double lat1 = double.parse(latitude);
    double lon1 = double.parse(longitude);
    double lat2 = double.parse(lat!);
    double lon2 = double.parse(long!);

    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$lat1,$lon1&destination=$lat2,$lon2&key=AIzaSyDpmfdMzey3-Jc9Z3KnEZyCxeDg753yKnI';

    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = jsonDecode(response.body);
    int distanceInMeters = data['routes'][0]['legs'][0]['distance']['value'];

    double distanceInKilometers = distanceInMeters / 1000;

    setState(() {
      this.distanceInMeters = '${distanceInKilometers.toStringAsFixed(1)} Km';
    });

    addData();
  }

  Future<void> _checkInfo() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Sair",
          title: "DIGITE OQUE O MOTOBOY TROUXE:",
          customColumns: [
            Container(
              margin: const EdgeInsets.only( bottom: 20.0 ),
              child:  textField(
                hintText: "MARKETING // FERRAMENTA",
                icon: FontAwesomeIcons.objectGroup,
                inputType: TextInputType.text,
                maxLines: 2,
                controller: _textController,
              ),
            )
          ],
          onConfirm: () async  {
            _artDialogKey.currentState?.showLoader();
            setState(() {
              outrosS = _textController.text.trim();

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


  Future<void> _checkInfo2() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Sair",
          title: "DIGITE OQUE FOI LEVADO:",
          customColumns: [
            Container(
              margin: const EdgeInsets.only( bottom: 20.0 ),
              child:  textField(
                hintText: "LEVOU URNA // FOLHETO / A4",
                icon: FontAwesomeIcons.objectGroup,
                inputType: TextInputType.text,
                maxLines: 2,
                controller: _textController2,
              ),
            )
          ],
          onConfirm: () async  {
            _artDialogKey.currentState?.showLoader();
            setState(() {
              outrosLS = _textController2.text.trim();

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

  Future<void> _checkInfo3() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Sair",
          title: "DIGITE QUAIS OS FORAM LEVADAS:",
          customColumns: [
            Container(
              margin: const EdgeInsets.only( bottom: 20.0 ),
              child:  textField(
                hintText: "1678/1890",
                icon: FontAwesomeIcons.objectGroup,
                inputType: TextInputType.text,
                maxLines: 2,
                controller: _textController3,
              ),
            )
          ],
          onConfirm: () async  {
            _artDialogKey.currentState?.showLoader();
            setState(() {
              _osL = _textController3.text.trim();

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

  Future<void> _checkInfo4() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Sair",
          title: "DIGITE QUAIS OS CHEGARAM:",
          customColumns: [
            Container(
              margin: const EdgeInsets.only( bottom: 20.0 ),
              child:  textField(
                hintText: "1567/1987",
                icon: FontAwesomeIcons.objectGroup,
                inputType: TextInputType.text,
                maxLines: 2,
                controller: _textController4,
              ),
            )
          ],
          onConfirm: () async  {
            _artDialogKey.currentState?.showLoader();
            setState(() {

              _os = _textController4.text.trim();

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




