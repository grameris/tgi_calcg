import 'package:flutter/material.dart';

class Malha extends StatefulWidget {
  @override
  _MalhaState createState() => _MalhaState();
}

class _MalhaState extends State<Malha> {
  double resultado, porcetagem;
  int _radioValue1, escolha;

  final areaController = TextEditingController();
  bool _validate = false;

  final _Key = GlobalKey<FormState>();

  void _areaChanged(String text) {
    if (text.isEmpty) {
      areaController.text = "";
      return;
    }
  }

  void _clear() {
    setState(() {
      areaController.clear();
      _radioValue1 = 0;
      _validate = false;
    });
  }

  void _calcular() {
    final _formKey = GlobalKey<FormState>();
    _reset() {
      _formKey.currentState.reset();
    }

    setState(() {
      switch (_radioValue1) {
        case 1:
          porcetagem = (((int.parse(areaController.text)) * 10) / 100);
          resultado = ((int.parse(areaController.text) + porcetagem) / 6)
              .round()
              .toDouble();
          break;
        case 2:
          porcetagem = (((int.parse(areaController.text)) * 10) / 100);
          resultado = ((int.parse(areaController.text) + porcetagem) / 14.5)
              .round()
              .toDouble();
          break;
      }
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Malha de Aço',
                  style: TextStyle(fontSize: 18.0, color: Colors.blueAccent,fontWeight: FontWeight.bold),)
            ]),
            textAlign: TextAlign.center,),
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
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'Valor da malha: ',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black)),
                            TextSpan(
                                text: '$resultado (UN)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    fontSize: 18.0)),
                          ]))),
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

//malha 2x3
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
                  Row(children: <Widget>[
                    new Radio(
                      value: 1,
                      groupValue: _radioValue1,
                      activeColor: Colors.white,
                      onChanged: (newValue) =>
                          setState(() => _radioValue1 = newValue),
                    ),
                    new Text(
                      'Malha 2 x 3',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    Divider(color: Colors.transparent),
                    new Radio(
                      value: 2,
                      groupValue: _radioValue1,
                      activeColor: Colors.white,
                      onChanged: (newValue) =>
                          setState(() => _radioValue1 = newValue),
                    ),
                    new Text(
                      'Malha 2,45 x 6',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ]),
                  Divider(color: Colors.transparent),
                  buildTextField("Area(m²)", areaController, _areaChanged),
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
                            side: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                ])));
  }
}

Widget buildTextField(String label, TextEditingController c, Function f) {
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
