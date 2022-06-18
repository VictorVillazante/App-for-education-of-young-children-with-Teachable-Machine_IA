class Animales{
  String _nombre;
  String _descripcion;
  String _imagen;
  String _sonido;
  Animales(this._nombre,this._descripcion,this._imagen,this._sonido);
  String get nombre=> this._nombre;
  String get descripcion=> this._descripcion;
  String get imagen=> this._imagen;
  String get sonido=> this._sonido;
  set nombre(String nombre){
    this._nombre=nombre;
  }
  set descripcion(String nombre){
    this._descripcion=nombre;
  }
  set imagen(String nombre){
    this._imagen=nombre;
  }
  set sonido(String nombre){
    this._sonido=nombre;
  }
}