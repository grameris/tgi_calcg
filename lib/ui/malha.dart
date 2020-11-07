import 'package:flutter/material.dart';

class Malha extends StatefulWidget {
  @override
  _MalhaState createState() => _MalhaState();
}

class _MalhaState extends State<Malha> {

  double resultado, porcetagem;



  final areaController = TextEditingController();
  bool _validate = false;


  final _Key = GlobalKey<FormState>();

  void _areaChanged(String text) {
    if (text.isEmpty) {
      areaController.text = "";
      return;
    }
  }

  void _clear(){
    setState(() {
    areaController.clear();
    _validate = false;
    });
  }

  void _calcular(){
    final _formKey = GlobalKey<FormState>();
    _reset(){
      _formKey.currentState.reset();
    }

    setState(() {
      porcetagem = (((int.parse(areaController.text))*10)/100);
      resultado = ((int.parse(areaController.text)+ porcetagem)/6).round().toDouble() ;
    });
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
                                    TextSpan(text:'Valor da malha: ', style: TextStyle(fontSize: 20.0,color: Colors.black)),
                                    TextSpan(text:'$resultado (UN)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 20.0)),
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
          buildTextField("Area(m²)", areaController,_areaChanged),
            Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Container(
                height: 50.0,

                child: RaisedButton(
                  onPressed: ()  {
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
      ]
    )

    ));

  }

}



Widget buildTextField(String label, TextEditingController c, Function f){
  return TextFormField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
    ),
    style: TextStyle(
        color: Colors.white, fontSize: 20.0
    ),
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