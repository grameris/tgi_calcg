import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vigota extends StatefulWidget {
  @override
  _VigotaState createState() => _VigotaState();
}

class _VigotaState extends State<Vigota> {
  var _altura = ["H8", "H12", "H16"];
  var _dist = ["40", "50"];
  var _espessura = ["4", "5"];
  var _sobrecarga = ["50", "100", "150", "200", "250", "300", "350", "400","450", "500", "550", "600", "650", "700", "750", "800","850", "900", "950", "1000", "1050", "1100", "1150", "1200", "1250", "1300", "1350", "1400", "1450","1500"];
  var _alturaviga = ["9", "12"];
  var _arranjo = ["2010", "3010", "3110", "4110", "4111", "4111E"];

  var altura, dist, espessura, sobrecarga, alturaviga, arranjo, zeroesc, umesc, dosesc;
  bool _validate = false;
  final _key = GlobalKey<FormState>();


_clear(){
  setState(() {
    altura = null;
    sobrecarga = null;
    arranjo = null;
    _validate = false;
  });
}


_consulta() async {
  final _formKey = GlobalKey<FormState>();
  _reset(){
    _formKey.currentState.reset();
  }
    QuerySnapshot snapshot = await Firestore.instance.collection(altura).document(arranjo).collection("sobrecarga$sobrecarga").getDocuments();
    snapshot.documents.forEach((d) {
      zeroesc = d["0escora"].toString();
      umesc   = d["1escora"].toString();
      dosesc  = d["2escora"].toString();

    });
    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: RichText(
                    text: TextSpan(children: <TextSpan>[
                    TextSpan(
                    text: 'Viga Protendida',
                    style: TextStyle(fontSize: 18.0, color: Colors.blueAccent,fontWeight: FontWeight.bold),)
                ]),textAlign: TextAlign.center,),
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -80.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                            _reset();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(text:'0 Escoras: ', style: TextStyle(fontSize: 20.0,color: Colors.black)),
                                        TextSpan(text:'$zeroesc', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 20.0)),
                                      ]
                                  ),
                                textAlign: TextAlign.center
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(text:'1 Escoras: ', style: TextStyle(fontSize: 20.0,color: Colors.black)),
                                        TextSpan(text:'$umesc', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 20.0)),
                                      ]
                                  ),
                                textAlign: TextAlign.center
                              )
                            ),
                            Padding(
                             padding: EdgeInsets.all(8.0),
                             child: RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       TextSpan(text:'2 Escoras: ', style: TextStyle(fontSize: 20.0,color: Colors.black)),
                                       TextSpan(text:'$dosesc', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 20.0)),
                                     ]
                                 ),
                               textAlign: TextAlign.center)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
    _clear();
  }





  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: new Form(
            key: _key,
            autovalidate: _validate,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Selecione a Altura:",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
              ),
              Divider(color: Colors.transparent),
              DropdownButtonFormField<String>(
                value: altura,
                onChanged: (String novoItem) {
                  setState(() {
                    altura = novoItem;
                  });
                },
                isExpanded: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  )
                ),
                validator: (value) => altura == null ? 'Campo Obrigatorio' : null,
                items: _altura.map((String item) {
                  return new DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  );
                }).toList(),
              ),
              Divider(color: Colors.transparent),
              Text("Selecione a Sobrecarga:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              Divider(color: Colors.transparent),
              DropdownButtonFormField<String>(
                value: sobrecarga,
                onChanged: (String novoItem) {
                  setState(() {
                    sobrecarga = novoItem;
                  });
                },
                isExpanded: true,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    )
                ),
                validator: (value) => sobrecarga == null ? 'Campo Obrigatorio' : null,
                items: _sobrecarga.map((String item) {
                  return new DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  );
                }).toList(),
              ),
              Divider(color: Colors.transparent),
              Text("Selecione o Arranjo da Viga:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              Divider(color: Colors.transparent),
              DropdownButtonFormField<String>(
                value: arranjo,
                onChanged: (String novoItem) {
                  setState(() {
                    arranjo = novoItem;
                  });
                },
                isExpanded: true,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    )
                ),
                validator: (value) => arranjo == null ? 'Campo Obrigatorio' : null,
                items: _arranjo.map((String item) {
                  return new DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: ()  {
                      if (_key.currentState.validate()) {
                        // Sem erros na validação
                        _key.currentState.save();
                        _consulta();
                      } else {
                        // erro de validação
                        setState(() {
                          _validate = true;
                        });
                      }


                    },
                    child: Text("Calcular",
                        style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center),
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)
                    ),
                  ),
                ),
              ),
            ])
        )
    );
  }
}