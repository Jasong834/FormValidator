import 'package:form/src/providers/productos_provider.dart';
import 'package:rxdart/subjects.dart';

import 'package:form/src/models/producto-model.dart';


class ProductosBloc {
  
  final _productoController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productoProvider = new ProductosProvider();


  Stream<List<ProductoModel>> get productoStream => _productoController;
  Stream<bool> get cargandoStream => _cargandoController; 


  dispose(){
    _cargandoController?.close();
    _productoController?.close();
  }

}







