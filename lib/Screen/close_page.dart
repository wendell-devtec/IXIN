import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:dropdown_search/dropdown_search.dart';
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

class ClosePage extends StatefulWidget{

  const ClosePage({super.key});

  @override
  State<StatefulWidget> createState() => _ControlClosePage();
}

class _ControlClosePage extends State<ClosePage>{
  late FToast fToast;
  String? formatDate;
  late GlobalKey<ArtDialogState> _artDialogKey;
  GroupController controller = GroupController();
  final _textController = TextEditingController();
  final _textController2 = TextEditingController();

  String? _seller;

  String? luz;
  String? ar;
  String? tv;
  String? pc;
  String? cell;
  String? cx1;
  String? rt;
  String rtEv = '';


  String obs = '';

  String? problem;


  List<Map<String, dynamic>> _items = [];


  void addData(){


    const  url = "https://devtecapps.com.br/ixin/addFC.php";
    final uri = Uri.tryParse(url);

    http.post(uri!,body: {
      "nome": _seller,
      "loja": storeName,
      "data": formatDate,
      "luz": "$luz",
      "ar": "$ar",
      "cell": "$cell",
      "pc": "$pc",
      "cx": "$cx1",
      "retaguarda": rtEv ,
      "obs": obs
    }).then((value) {
      String msg = "REGISTRO DE FECHAMENTO CONCLUIDO";
      _showToastCancel(msg);
      _homeRoute();
    });
  }


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

    var dateFormat = DateFormat('dd/MM/yyyy').format(ntpTime);

    setState(() {
      formatDate = dateFormat;
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

    return LayoutBuilder(builder: (context,constraints){
      final bool isMobile = constraints.maxWidth < 600;

      return Scaffold(
          appBar: AppBar(
            title: Text("FECHAMENTO LOJA $storeName", style: const TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
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
                    Column(
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("DESLIGOU AS LUZES?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 19)),
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
                                    luz = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("DESLIGOU O AR CONDICIONADO",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),
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
                                    ar = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("DESLIGOU A TELEVISÃO?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 17),
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
                                    tv = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("DESLIGOU O COMPUTADOR?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 17),
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
                                    pc = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("COLOCOU CELULAR PARA CARREGAR",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 17),
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
                                    cell = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("CONFERIU O CAIXA?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 19),
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
                                    cx1 = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 0.5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("ENVIOU RETAGUARDA?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),
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
                                    rt = values;
                                  });

                                  if(rt == "SIM"){
                                    _checkInfo2();
                                  }


                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 0.5, top: 15),
                          child: Row(
                            children: [
                              const Center(
                                child: Text("HOUVE PROBLEMA AO FECHAR A LOJA?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),
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
                                    problem = values;
                                  });

                                  if(problem == "SIM"){
                                    _checkInfo();
                                  }


                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child:  SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            var msg = "VOCÊ NÃO SELECIONOU SEU NOME!!";
                            if(_seller == null){
                              _showToastCancel(msg);
                              return;
                            }
                            if(luz == null || ar == null || tv == null || cell == null || cx1 == null || rt == null){
                              msg = "OPS! VOCÊ DEIXOU DE MARCAR ALGUMA OPÇÃO";
                              _showToastCancel(msg);
                              return;
                            }
                            addData();

                          },
                          text: "SALVAR",
                        ),
                      ),
                    )


                  ]
              ),
            ),
          ):

          SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                  children: [
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
                                      borderSide: BorderSide(color: Colors.white),

                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white )
                                    ),
                                    hintText: "PESQUISE SEU NOME",
                                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white),
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
                    ),

                    Column(
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 5,top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text("DESLIGOU AS LUZES?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22)),
                              ),
                              SimpleGroupedChips<String>(
                                controller: controller,
                                values: const ["SIM" , "NÃO"],
                                itemTitle: const ["SIM" ,"NÃO"],
                                chipGroupStyle: ChipGroupStyle.minimize(
                                  backgroundColorItem: Colors.red[400],
                                  textColor: Colors.white,
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    luz = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text("DESLIGOU O AR CONDICIONADO",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    ar = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("DESLIGOU A TELEVISÃO?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    tv = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("DESLIGOU O COMPUTADOR?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    pc = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("COLOCOU CELULAR PARA CARREGAR",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    cell = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 5, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("CONFERIU O CAIXA?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    cx1 = values;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 0.5, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Center(
                                child: Text("ENVIOU RETAGUARDA?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    rt = values;
                                  });

                                  if(rt == "SIM"){
                                    _checkInfo2();
                                  }


                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(left: 0.5, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text("HOUVE PROBLEMA AO FECHAR A LOJA?",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 22),
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
                                    fontSize: 18,
                                  ),
                                ),
                                onItemSelected: (values) {
                                  setState(() {
                                    problem = values;
                                  });

                                  if(problem == "SIM"){
                                    _checkInfo();
                                  }


                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child:  SizedBox(
                        width: 150,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            var msg = "VOCÊ NÃO SELECIONOU SEU NOME!!";
                            if(_seller == null){
                              _showToastCancel(msg);
                              return;
                            }
                            if(luz == null || ar == null || tv == null || cell == null || cx1 == null || rt == null){
                              msg = "OPS! VOCÊ DEIXOU DE MARCAR ALGUMA OPÇÃO";
                              _showToastCancel(msg);
                              return;
                            }
                            addData();

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

  Future<void> _checkInfo2() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Sair",
          title: "DIGITE O VALOR ENVIADO COMO RETAGUARDA:",
          customColumns: [
            Container(
              margin: const EdgeInsets.only( bottom: 20.0 ),
              child:  textField(
                hintText: "890",
                icon: FontAwesomeIcons.moneyBillTransfer,
                inputType: TextInputType.text,
                maxLines: 1,
                controller: _textController2,
                maxLength: 10,
              ),
            )
          ],
          onConfirm: () async  {
            _artDialogKey.currentState?.showLoader();
            setState(() {
              rtEv = _textController2.text.trim();

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


  Future<void> _checkInfo() async {
    await ArtSweetAlert.show(
        barrierDismissible: false,
        artDialogKey: _artDialogKey,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Sair",
          title: "DIGITE SEU PROBLEMA:",
          customColumns: [
            Container(
              margin: const EdgeInsets.only( bottom: 20.0 ),
              child:  textField(
                hintText: "CAIXA ERRADO // COMPUTADOR QUEBRADO",
                icon: FontAwesomeIcons.doorClosed,
                inputType: TextInputType.text,
                maxLines: 2,
                controller: _textController,
              ),
            )
          ],
          onConfirm: () async  {
            _artDialogKey.currentState?.showLoader();
            setState(() {
              obs = _textController.text.trim();

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




