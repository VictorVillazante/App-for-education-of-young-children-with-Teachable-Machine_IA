import 'dart:math';

import 'package:flutter/material.dart';
class Rompecabezas extends StatefulWidget {
  @override
  _RompecabezasState createState() => _RompecabezasState();
}

class _RompecabezasState extends State<Rompecabezas> {
  void initState(){
    super.initState();
    print("inicia estado");
    sortearPosiciones();
  }
  sortearPosiciones(){
    int numero=0;
    print("sortea posiciones");
    for(int i=0;i<9;i++){
      numero=Random().nextInt(9);
      int aux=posicionesElementos[i];
      posicionesElementos[i]=posicionesElementos[numero];
      posicionesElementos[numero]=aux;
      establecerXYporPosicion();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/fondo_rompecabezas.jpg')
                  )
              ),
            ),
            obtenerElemento(4),
            obtenerElemento(5),
            obtenerElemento(6),
            obtenerElemento(7),
            obtenerElemento(8),
            obtenerElemento(9),
            obtenerElemento(1),//La posicion de los elementos cortados es la posicion del elemento padre esquena superior izquierda solo que se vera lo cortado
            obtenerElemento(2),//Los elementos cortados siguen ocupado el espacio del elemento padre pero muestran lo cortado
            obtenerElemento(3),

          ],
        ),
      ),
    );
  }
  Widget obtenerElemento(int e) {
    double x,y;
    switch(e){
      case 1:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];//El stack permite que te salgas de los limites por eso puedo usar 6.6
        break;
      case 2:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 3:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 4:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 5:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 6:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 7:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 8:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
      case 9:
        x=posicionXposicionYelementos[e-1][0];//Representa que se movera 20 porciento del porcentaje que le sobra a la izquierda (-0.2) si es 0.2 el contenedor se mueve 20 porciento del porcentaje que le sobro a la derecha
        y=posicionXposicionYelementos[e-1][1];
        break;
    }
    List colores=[Colors.red,Colors.amber,Colors.pinkAccent,Colors.greenAccent,Colors.limeAccent,Colors.brown,Colors.pink,Colors.purple,Colors.indigo];
    return Align(
      alignment: Alignment(x,y),
      child: ClipPath(
        clipper: Cortes(e),
        child: Card(
          elevation: (e==1)?100:0,
          child: GestureDetector(
            onTap: (){
              setState(() {//Siempe colocar setState cunado actualizamos un valor
                listaClic1ElementosRompecabezas[e-1]=true;
                cambiarPosicionElementos(e-1);
                verificarVictoria();
              });
              print("detecta presion");
            },
            child: Container(
              width: 300,//El tamaño de mi imagen que luego cortaresmos pero seguira ocupando el mismo espacio por lo que colocarlo dentro de un container padre no es buena idea pero si dentro de un stack, esto por sus limites que no se sobreponene y se respetan
              height: 300,
              //padding: const EdgeInsets.all(5),
              color: colores[e-1],
              child: (true)?Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/canguro.jpg'
                ),
              ):null
            ),
          ),
        ),
      ),
    );
  }
  List movimientosXparaPos1=[0,3.34,6.68];
  List movimientosXparaPos2=[-3.34,0,3.34];
  List movimientosXparaPos3=[-6.68,-3.34,0];
  List movimientosYParaPos1=[0,0.6555,0.6555*2];
  List movimientosYParaPos2=[0,0.66,1.315];
  List movimientosYParaPos3=[0,0.66,1.315];
  void cambiarPosicionElementos(int elemento) {
    elementosSeleccionados.add(elemento);
    if(elementosSeleccionados.length==2){
      print("se seleccionaron 2");
      print(posicionesElementos);
      int aux=posicionesElementos[elementosSeleccionados[0]];
      posicionesElementos[elementosSeleccionados[0]]=posicionesElementos[elementosSeleccionados[1]];
      posicionesElementos[elementosSeleccionados[1]]=aux;
      print(posicionesElementos);
      establecerXYporPosicion();
      listaClic1ElementosRompecabezas[elementosSeleccionados[0]]=false;
      listaClic1ElementosRompecabezas[elementosSeleccionados[0]]=false;
      elementosSeleccionados=[];
    }
  }
  List posicionXposicionYelementos=[
    [0.0,0.0],[0.0,0.0],[0.0,0.0],[0.0,0.0],[0.0,0.0],[0.0,0.0],[0.0,0.0],[0.0,0.0],[0.0,0.0]
  ];
  List posicionesElementos=[1,4,8,3,0,5,7,6,2];

  void establecerXYporPosicion() {
    for(int i=0;i<9;i++){
      int posicion=posicionesElementos[i];
      int posicionFuturaY=(posicion/3).toInt();
      int posicionFuturaX=(posicion%3);
      int posicionNaturalX=i%3;
      int posicionNaturalY=(i/3).toInt();
      if(posicionFuturaX>posicionNaturalX){
        int numeroMovimientos=posicionFuturaX-posicionNaturalX;
        posicionXposicionYelementos[i][0]=numeroMovimientos*3.8;
      }else{
        if(posicionNaturalX>posicionFuturaX){
          int numeroMovimientos=posicionNaturalX-posicionFuturaX;
          posicionXposicionYelementos[i][0]=-numeroMovimientos*3.8;
        }
        else{
          posicionXposicionYelementos[i][0]=0.0;
        }
      }
      if(posicionFuturaY>posicionNaturalY){
        int numeroMovimientos=posicionFuturaY-posicionNaturalY;
        posicionXposicionYelementos[i][1]=numeroMovimientos*0.6555;
      }else{
        if(posicionNaturalY>posicionFuturaY){
          int numeroMovimientos=posicionNaturalY-posicionFuturaY;
          posicionXposicionYelementos[i][1]=-numeroMovimientos*0.6555;
        }
        else{
          posicionXposicionYelementos[i][1]=0.0;
        }
      }
    }
  }

  void verificarVictoria() {
    List listaAciertos=[false,false,false,false,false,false,false,false,false];
    bool victoria=true;
    for(int i=0;i<9;i++){
      if(posicionesElementos[i]==i){
        listaAciertos[i]=true;
      }else{
        victoria=false;
      }
    }
    if(victoria){
      listaClic1ElementosRompecabezas=listaAciertos;
      print("victoria");
    }
  }
}
List listaClic1ElementosRompecabezas=[false,false,false,false,false,false,false,false,false];
List <int>elementosSeleccionados=[];
class Cortes extends CustomClipper<Path>{
  int _e;
  Cortes(this._e);
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double w=size.width;
    double h=size.height;
    Path path=Path();
    switch(_e){
      case 1:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.03:0, (!listaClic1ElementosRompecabezas[_e-1])?h*0.03:0);//Probar la logica antes de confirmar que no nos permite hacer esa accion
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.32:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.03:0);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.32:w/3,(!listaClic1ElementosRompecabezas[_e-1])?h*0.32:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.03:0, (!listaClic1ElementosRompecabezas[_e-1])?h*0.32:h/3);
        break;
      case 2:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.34:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.03:0);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.65:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.03:0);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.65:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.32:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.34:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.32:h/3);
        break;
      case 3:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.67:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.025:0);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.98:w, (!listaClic1ElementosRompecabezas[_e-1])?h*0.025:0);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.98:w, (!listaClic1ElementosRompecabezas[_e-1])?h*0.32:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.67:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.32:h/3);
        break;
      case 4:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.03:0, (!listaClic1ElementosRompecabezas[_e-1])?h*0.34:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.32:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.34:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.32:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.65:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.03:0, (!listaClic1ElementosRompecabezas[_e-1])?h*0.65:h*2/3);
        break;
      case 5:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.34:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.34:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.65:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.34:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.65:w*2/3,(!listaClic1ElementosRompecabezas[_e-1])? h*0.65:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.34:w/3,(!listaClic1ElementosRompecabezas[_e-1])? h*0.65:h*2/3);
        break;
      case 6:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.67:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.34:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.98:w, (!listaClic1ElementosRompecabezas[_e-1])?h*0.34:h/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.98:w, (!listaClic1ElementosRompecabezas[_e-1])?h*0.65:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.67:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.65:h*2/3);
        break;
      case 7:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.03:0, (!listaClic1ElementosRompecabezas[_e-1])?h*0.67:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.32:w/3,(!listaClic1ElementosRompecabezas[_e-1])? h*0.67:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.32:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.98:h);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.03:0, (!listaClic1ElementosRompecabezas[_e-1])?h*0.98:h);
        break;
      case 8:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.34:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.67:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.65:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.67:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.65:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.98:h);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.34:w/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.98:h);
        break;
      case 9:
        path.moveTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.67:w*2/3, (!listaClic1ElementosRompecabezas[_e-1])?h*0.67:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.98:w, (!listaClic1ElementosRompecabezas[_e-1])?h*0.67:h*2/3);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.98:w, (!listaClic1ElementosRompecabezas[_e-1])?h*0.98:h);
        path.lineTo((!listaClic1ElementosRompecabezas[_e-1])?w*0.67:w*2/3,(!listaClic1ElementosRompecabezas[_e-1])? h*0.98:h);
        break;
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(Cortes oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
