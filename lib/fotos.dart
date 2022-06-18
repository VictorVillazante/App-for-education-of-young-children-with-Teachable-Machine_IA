import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_proyecto_flutter/1menu_principal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

import 'transiciones.dart';

class Fotos extends StatefulWidget {
  @override
  _FotosState createState() => _FotosState();
}

class _FotosState extends State<Fotos> {
  FlutterTts fluttertts = FlutterTts();//Para convertir txt a voz
  Timer timer;//Permite repetir instrucciones para elegir imagen
  List _outputs;//Almacena informacion de la prediccion
  bool _loading=false;//Permite controlar que se cargue el modelo
  List oraciones;//Intrucciones para elegir imagen
  bool cambioInterfaz=false;//Para terminar con la repeticion de intrucciones
  bool mostrarBoton=false;//Para cambiar formato del boton
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading=true;
    loadModel().then((valor){//cargamos el modelo despues mostramos la interfaz sin imagen
      setState(() {
        _loading=false;
      });
    });
    mostrarOpciones();//Permite iniciar con la repeticion de insturcciones
  }
  loadModel() async {//Carga el modelo de tensorflow lite, importante colocarlo en el initState
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",//ruta del modelo
      labels: "assets/labels.txt",//ruta de las respuestas
    );
  }
  void mostrarOpciones(){
    oraciones=[
      "Bienvenido, captura una foto y descubre que animal es",
      "Presiona en este boton para elegir la imagen",
    ];
    speak(oraciones[0]);
    cambioInterfaz=false;
    //Solo cuando se a dado un pop al elemento en navegacion el timer es destruido
    timer=Timer.periodic(Duration(seconds: 12), (timer) {//cuando eliminar un timer este ejecuta su ultimo loop, y si vas a cambiar algun valor booleano pensando que ya lo eliminaste y no lo tomara en cuenta estas mal poque si lo tomara en cuenta y puede haber dos timers hasta que el primer timer eliminado termine su ultimo loop
      setState(() {
        //speak("elige una de las opciones");
        Future.delayed(Duration(seconds: 7),(){
          mostrarBoton=!mostrarBoton;
          (cambioInterfaz)?null:speak(oraciones[1]);

          //print(muestreoOpciones[0]);
        });      });
    });
  }
  speak(String mensaje) async{//Metodo que permite convertir texto a voz
    await fluttertts.setPitch(0.8);
    await fluttertts.setLanguage("es-US");
    await fluttertts.setSpeechRate(1.0);
    await fluttertts.setVolume(0.2);
    await fluttertts.speak(mensaje);
  }
  final GlobalKey<ScaffoldState>keyScaffold=new GlobalKey();//Permite obtener el contexto del scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(title: Text('Tomar fotos'),
        actions: [
          IconButton(icon: Icon(Icons.arrow_back,size: 40,), onPressed: (){
            Navigator.pop(context);
            Navigator.push(context,FadeRoute(page: MenuPrincipal() ));//primero el push y luego el pop no sirve
          }),
          SizedBox(width: 20,),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit:BoxFit.cover,
              image: AssetImage("assets/ifc.jpg")//Imagen de fondo
          )
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: cuerpoSeccion(),
          ),
        ),
      ),
    );
  }

  Widget cuerpoSeccion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (_loading)?//Si se cargo el modelo nos muestra los widgets, sino un circularProgress que representa que esta cargando el modelo
          Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ):
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _imagen==null?//Controla que se haya elegido una imagen
                  Container():
                  Image.file(_imagen),
                (_outputs!=null && _outputs.isNotEmpty)?//Controla que se haya obtenido una respueta del modelo
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text('Le tomaste una foto a un ${_outputs[0]['label']}!!!'),
                  ):
                (_outputs!=null && _outputs.isEmpty)?//Controla que la respuesta haya clasificado a la imagen
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text('No puedo identificar la imagen'),
                  ):
                Container()
              ],
            ),
          )
        ,botonEleccionImagen()
      ],
    );
  }

  Widget botonEleccionImagen() {//Es el boton que permite mostrar las opciones de tomar la foto por camara o galeria
    return GestureDetector(
      onTap: (){
        timer.cancel();
        seleccionarOpcion(keyScaffold.currentContext);//Muestra las opciones para tomar la imagen
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.blue,width: 2),
            left: BorderSide(color: Colors.blue,width: 2),
            top: BorderSide(color: Colors.blue,width: 2),
            bottom: BorderSide(color: Colors.blue,width: 2),
          ),
          color: (mostrarBoton)?Colors.white:Colors.blue,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera,color:(mostrarBoton)?Colors.blue: Colors.white,),
            SizedBox(width: 10,),
            Text('Tomar fotos',style: TextStyle(color: (mostrarBoton)?Colors.blue:Colors.white),),
          ],
        ),
      ),
    );
  }

  void seleccionarOpcion(BuildContext currentContext) {
    opcionesMenuImagenes();
    showModalBottomSheet(
        context: currentContext,
        builder: (BuildContext builder){
          return Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Wrap(
              children: [
                ListTile(
                  tileColor: opcionImagen?Colors.white:Colors.blue,
                  leading: Icon(Icons.camera_alt,color: opcionImagen?Colors.black:Colors.white,),
                  title: Text('Tomar foto',style: TextStyle(color: opcionImagen?Colors.black:Colors.white),),
                  onTap: (){
                    irACamara();//Nos permite tomar una foto
                    timer.cancel();//Termina la repeticion de instrucciones
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  tileColor: opcionImagen?Colors.blue:Colors.white,
                  leading: Icon(Icons.photo,color:opcionImagen? Colors.white:Colors.black),
                  title: Text('Analizar galeria',style: TextStyle(color:opcionImagen?Colors.white: Colors.black),),
                  onTap: (){
                    irAGaleria();//Nos permite seleccionar imagen de galeria
                    timer.cancel();//Termina repeticion de instrucciones
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          );
        }
    );
  }
  bool opcionImagen=true;
  void opcionesMenuImagenes(){
    oraciones=[
      "Toma una fotografia",
      "Elige una imagen que ya tengas",
    ];
    //Solo cuando se a dado un pop al elemento en navegacion el timer es destruido
    timer=Timer.periodic(Duration(seconds: 20), (timer) {//cuando eliminar un timer este ejecuta su ultimo loop, y si vas a cambiar algun valor booleano pensando que ya lo eliminaste y no lo tomara en cuenta estas mal poque si lo tomara en cuenta y puede haber dos timers hasta que el primer timer eliminado termine su ultimo loop
      setState(() {
        //speak("elige una de las opciones");
        Future.delayed(Duration(seconds: 7),(){
          (cambioInterfaz)?null:speak(oraciones[0]);
          setState(() {
            opcionImagen=!opcionImagen;
          });
        });
        Future.delayed(Duration(seconds: 14),(){
          (cambioInterfaz)?null:speak(oraciones[1]);
          setState(() {
            opcionImagen=!opcionImagen;
          });
        });
      });
    });
  }
  var imageFile;
  File _imagen;
  Future<void> irACamara() async {
    print('camara');
    var imagen= await ImagePicker.pickImage(source: ImageSource.camera);
    if(imagen==null)return null;
    imageFile= await imagen.readAsBytes();
    imageFile= await decodeImageFromList(imageFile);
    setState(() {
      imageFile=imageFile;
      _imagen=imagen;
    });
    predecirImagen(imagen);//metodo para obtener la clasificacion de la imagen, respuesta del modelo
  }
  Future<void> irAGaleria() async {
    print('galeria');
    var imagen=await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imagen==null)return null;
    imageFile= await imagen.readAsBytes();
    imageFile= await decodeImageFromList(imageFile);
    setState(() {
      imageFile=imageFile;
        _imagen=imagen;
    });
    predecirImagen(imagen);//metodo para obtener la clasificacion de la imagen, respuesta del modelo
  }

  Future<void> predecirImagen(File imagen) async {
    var output= await Tflite.runModelOnImage(
        path:imagen.path,
        numResults: 1,
        threshold:0.5,
        imageMean:127.5,
        imageStd: 127.5
    );
    setState(() {
      _loading=false;
      _outputs=output;
      speak('Le tomaste una foto a un ${_outputs[0]['label']}');
    });
  }
  void dispose() {
    Tflite.close();//Es necesario usar .close() en el objeto TFlite al salirnos de la interfaz
    super.dispose();
  }
}
