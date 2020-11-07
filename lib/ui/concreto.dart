import 'package:flutter/material.dart';

class Concreto extends StatefulWidget {
  @override
  _ConcretoState createState() => _ConcretoState();
}

class _ConcretoState extends State<Concreto> {
  var _altura = ["H8", "H12", "H16"];
  var altura;
  double resultado;
  bool _validate = false;
  final _Key = GlobalKey<FormState>();

  final areaController = TextEditingController();

  void _areaChanged(String text) {
    if (text.isEmpty) {
      areaController.text = "";
      return;
    }
  }

  void _clear(){
    setState(() {
    areaController.clear();
    altura = null;
    _validate = false;
    });
  }

  void _calcular() {
    final _formKey = GlobalKey<FormState>();
    _reset(){
      _formKey.currentState.reset();
    }
    if (altura == "H8") {
      resultado = (((int.parse(areaController.text))*10)/1000);
    }else if (altura == "H12"){
      resultado = (((int.parse(areaController.text))*20)/1000);;
    }else {
      resultado = (((int.parse(areaController.text))*30)/1000);;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
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
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text:'Valor do valor: ', style: TextStyle(fontSize: 20.0,color: Colors.black,)),
                                    TextSpan(text:'$resultado (M²)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 20.0)),
                                  ]
                              )
                          )
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
        }
    );
    _clear();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
    child: new Form(
    key: _Key,
    autovalidate: _validate,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildTextField("Area(m²)",areaController, _areaChanged),
              Divider(color: Colors.transparent),
              Text("Selecione a Arranjo da Viga:",
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
                    child: Text(item, style: TextStyle(fontSize: 20.0)),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_Key.currentState.validate()) {
                        // Sem erros na validação
                        _Key.currentState.save();
                        _calcular();
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
            ])));
  }
}

Widget buildTextField(
    String label, TextEditingController c, Function f) {
  return TextFormField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
    ),
    style: TextStyle(color: Colors.white, fontSize: 20.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    validator: (value) {
      if (value.isEmpty) {
        return 'Campo Obrigatorio';
      }
      return null;
    },
  );
}

