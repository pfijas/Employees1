import 'dart:convert';
import 'package:employees/Models/SettingsSave.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/Settings.dart';
import '../Utils/GlobalFn.dart';

class logsettings extends StatefulWidget {
  const logsettings({Key? key}) : super(key: key);

  @override
  State<logsettings> createState() => _logsettingsState();
}

class _logsettingsState extends State<logsettings> {
  String? DeviceId = "";
  SQLMessage? sqlMessage;
  List<TableClass>? tableClass;
  List<KOTVoucher>? kotVoucher;
  List<TAVoucher>? taVoucher;
  List<PrintArea>? printArea;

  //single dropdown items
  TableClass? selTableClass;
  KOTVoucher? selKOTVoucher;
  TAVoucher? selTAVoucher;
  PrintArea?selFirstprint;
  PrintArea?selSecondprint;
  PrintArea?selThirdprint;
  PrintArea?selFourthprint;
  PrintArea?selFifthprint;

  final ipController1 = TextEditingController();
  final ipController2 = TextEditingController();
  final ipController3 = TextEditingController();
  final ipController4 = TextEditingController();
  final ipController5 = TextEditingController();


  @override
  void initState() {
    fetchData();
    super.initState();

    //selTableClass = tableClass?.firstWhere((tableClass) => tableClass.selected == "Y");
  }

  Future<void>SaveSettings() async{
    SettingsSave settingsSave = SettingsSave();
    settingsSave.devideInfo = DeviceInfo(deviceId: await fnGetDeviceId());
    List<SettingsList> settingsList = [];

    if(selTableClass !=null){
      settingsList.add(SettingsList(
          identifierKey:"SETT_TAB_AREA",
          identifierValue:selTableClass?.className,
      ));
    }
    if(selKOTVoucher !=null){
      var settings = SettingsList(
          identifierKey:"SETT_TAB_KOT_LID",
          identifierValue: selKOTVoucher?.ledId.toString(),
      );
      settingsList.add(settings);
    }
   if(selTAVoucher !=null){
     settingsList.add (SettingsList(
       identifierKey: "SETT_TAB_TA_LID",
       identifierValue: selTAVoucher?.ledgerName,
     ));
   }
   if(selFirstprint !=null){
     settingsList.add(SettingsList(
       identifierValue: selFirstprint?.printAreaName,
       identifierKey: "SETT_TAB_PA1",
     ));
   }
   if(selSecondprint !=null){
     settingsList.add(SettingsList(
       identifierValue: selSecondprint?.printAreaName,
       identifierKey: "SETT_TAB_PA2",
     ));
   }

   if(selThirdprint !=null){
     settingsList.add(SettingsList(
       identifierValue: selThirdprint?.printAreaName,
       identifierKey:  "SETT_TAB_PA3",
     ));
   }
   if(selFourthprint !=null){
     settingsList.add(SettingsList(
       identifierValue: "SETT_TAB_PA4",
       identifierKey: selFourthprint?.printAreaName,
     ));
   }
   if(selFifthprint !=null){
     settingsList.add(SettingsList(
       identifierValue: "SETT_TAB_PA5",
       identifierKey: selFifthprint?.printAreaName,
     ));
   }


    settingsSave.settingsList = settingsList;
    //var jsonSettings = jsonEncode(settingsSave);
    //print('jsonSettings${jsonSettings}');

   var jsonData = jsonEncode({
     "DevideInfo": settingsSave.devideInfo?.toJson(),
     "Settings": settingsSave.settingsList
   });

    print('jsonSettings${jsonData}');

    final String? baseUrl = await fnGetBaseUrl();
    final String apiUrl = '${baseUrl}api/Settings/save';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(jsonData),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print("ddddd$jsonResponse");
    }

  }


  Future<void> fetchData() async {
    DeviceId = await fnGetDeviceId();
    final String? baseUrl = await fnGetBaseUrl();
    String apiUrl = '${baseUrl}api/Settings/data';

    try {
      apiUrl = '$apiUrl?DeviceId=$DeviceId';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Settings settings = Settings.fromJson(json.decode(response.body));

        sqlMessage = settings.data?.sQLMessage;

        if (sqlMessage?.code == "200") {
          tableClass = settings.data?.tableClass;
          kotVoucher = settings.data?.kOTVoucher;
          taVoucher = settings.data?.tAVoucher;
          printArea = settings.data?.printArea;

          printArea?.forEach((area) {
            print('${area.printAreaName}');
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Row(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 130, bottom: 10, left: 10, right: 10),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Table Class",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "   KOT Voucher",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "  T A Voucher",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 36,
                          ),
                          Column(
                            children: [
                              DropdownButton<TableClass>(
                                value: selTableClass,
                                onChanged: (TableClass? newArea) {
                                  setState(() {
                                    selTableClass=newArea;
                                  });
                                },
                                items: tableClass?.map<DropdownMenuItem<TableClass>>((TableClass tableArea){
                                  return DropdownMenuItem<TableClass>(
                                      value: tableArea,
                                      child: Text(tableArea.className.toString()),
                                  );
                                }).toList(),
                              ),
                              DropdownButton<KOTVoucher>(
                                value: selKOTVoucher,
                                onChanged: (KOTVoucher? newArea) {
                                  setState(() {
                                    selKOTVoucher=newArea;
                                  });
                                },
                                items: kotVoucher?.map<DropdownMenuItem<KOTVoucher>>((KOTVoucher kotArea){
                                  return DropdownMenuItem<KOTVoucher>(
                                    value: kotArea,
                                    child: Text(kotArea.ledgerName.toString()),
                                  );
                                }).toList(),
                              ),
                              DropdownButton<TAVoucher>(
                                value: selTAVoucher,
                                onChanged: (TAVoucher? newArea) {
                                  setState(() {
                                    selTAVoucher=newArea;
                                  });
                                },
                                items: taVoucher?.map<DropdownMenuItem<TAVoucher>>((TAVoucher tavArea){
                                  return DropdownMenuItem<TAVoucher>(
                                    value: tavArea,
                                    child: Text(tavArea.ledgerName.toString()),
                                  );
                                }).toList(),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        SaveSettings();
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Center(
                      child: Text(
                        "Print Settings",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Text("Print  Area", style: TextStyle(fontSize: 21)),
                              SizedBox(height: 20),
                              DropdownButton<PrintArea>(
                                value: selFirstprint,
                                onChanged: (PrintArea? newArea) {
                                  setState(() {
                                    selFirstprint=newArea;
                                  });
                                },
                                items: printArea?.map<DropdownMenuItem<PrintArea>>((PrintArea tavArea){
                                  return DropdownMenuItem<PrintArea>(
                                    value: tavArea,
                                    child: Text(tavArea.printAreaName.toString()),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButton<PrintArea>(
                                value: selSecondprint,
                                onChanged: (PrintArea? newArea) {
                                  setState(() {
                                    selSecondprint=newArea;
                                  });
                                },
                                items: printArea?.map<DropdownMenuItem<PrintArea>>((PrintArea tavArea){
                                  return DropdownMenuItem<PrintArea>(
                                    value: tavArea,
                                    child: Text(tavArea.printAreaName.toString()),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButton<PrintArea>(
                                value: selThirdprint,
                                onChanged: (PrintArea? newArea) {
                                  setState(() {
                                    selThirdprint=newArea;
                                  });
                                },
                                items: printArea?.map<DropdownMenuItem<PrintArea>>((PrintArea tavArea){
                                  return DropdownMenuItem<PrintArea>(
                                    value: tavArea,
                                    child: Text(tavArea.printAreaName.toString()),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButton<PrintArea>(
                                value: selFourthprint,
                                onChanged: (PrintArea? newArea) {
                                  setState(() {
                                    selFourthprint=newArea;
                                  });
                                },
                                items: printArea?.map<DropdownMenuItem<PrintArea>>((PrintArea tavArea){
                                  return DropdownMenuItem<PrintArea>(
                                    value: tavArea,
                                    child: Text(tavArea.printAreaName.toString()),
                                  );
                                }).toList(),
                              ), SizedBox(
                                height: 10,
                              ),
                              DropdownButton<PrintArea>(
                                value: selFifthprint,
                                onChanged: (PrintArea? newArea) {
                                  setState(() {
                                    selFifthprint=newArea;
                                  });
                                },
                                items: printArea?.map<DropdownMenuItem<PrintArea>>((PrintArea tavArea){
                                  return DropdownMenuItem<PrintArea>(
                                    value: tavArea,
                                    child: Text(tavArea.printAreaName.toString()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(width: 120,),
                          Column(
                            children: [
                              Text("Print  IP", style: TextStyle(fontSize: 21)),
                              SizedBox(height: 40,),
                              Container(
                                width: 100,
                                height: 20,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: ipController1,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                  ),
                                ),
                              ),
                              SizedBox(height:35),
                              Container(
                                width: 100,
                                height: 20,
                                child:  TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: ipController2,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                  ),
                                ),
                              ), SizedBox(height:35),
                              Container(
                                width: 100,
                                height: 20,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: ipController3,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                  ),
                                ),
                              ), SizedBox(height:35),
                              Container(
                                width: 100,
                                height: 20,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: ipController4,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                  ),
                                ),
                              ), SizedBox(height:35),
                              Container(
                                width: 100,
                                height: 20,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: ipController5,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 100),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
