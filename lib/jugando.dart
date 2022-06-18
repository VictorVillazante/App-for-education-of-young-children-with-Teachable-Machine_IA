import 'package:flutter/material.dart';
import 'package:flutter_app_proyecto_flutter/coloreando.dart';
import 'package:flutter_app_proyecto_flutter/identificaAnimal.dart';
import 'package:flutter_app_proyecto_flutter/rompecabezas.dart';
import 'package:flutter_app_proyecto_flutter/transiciones.dart';

import 'pares.dart';
class Jugando extends StatefulWidget {
  @override
  _JugandoState createState() => _JugandoState();
}

class _JugandoState extends State<Jugando> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu de juegos'),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img_jugando_fondo.jpg')
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    opcionJuego('Rompecabezas','assets/img_rompecabezas_juego.png',(){
                      Navigator.push(context,FadeRoute(page: Rompecabezas() ));
                    }),
                    opcionJuego('Busca pares','assets/busca_pares.jpg',(){
                      Navigator.push(context,FadeRoute(page: Pares()));
                    })
                  ]
                ),
                Row(
                  children:[
                    opcionJuego('Descubre el animal','assets/img_elige_animal.jpg',(){
                      Navigator.push(context, FadeRoute(page: IdentificaElAnimal()));
                    })
                  ]
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget opcionJuego(String nombre,String ruta,VoidCallback onPressed) {
    return Card(
      elevation: 20,
        color: Color.fromRGBO(189, 143, 53, 0.5),
        child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        width: 150,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
              ),
              height: 150,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  ruta
                ),
              ),
            ),
            Text(
              '${nombre}'
            ),
            Builder(
              builder:(context)=> RaisedButton(
                child: Text('Jugar'),
                color: Colors.greenAccent,
                onPressed:onPressed
              ),
            )
          ],
        ),
      )
    );
  }
}
