import 'package:flutter/material.dart';
import 'package:form/src/bloc/provider.dart';
import 'package:form/src/models/producto-model.dart';
import 'package:form/src/providers/productos_provider.dart';
class HomePage extends StatelessWidget {
final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed:()=>Navigator.pushNamed(context,'productos'),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          
          final productos = snapshot.data;
         
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,i)=>_crearItem(context,productos[i]),
          );
        }else{
          return Center(
            child : CircularProgressIndicator()
          );
        }
      },
    );
  }


  Widget _crearItem(BuildContext context, ProductoModel producto ) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ){
        productosProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ( producto.fotoUrl == null ) 
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                image: NetworkImage( producto.fotoUrl ),
                placeholder: AssetImage('assets/jar-loading (1).gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,

              ),
            
            ListTile(
              title: Text('${ producto.titulo } - ${ producto.valor }'),
              subtitle: Text( producto.id ),
              onTap: () => Navigator.pushNamed(context, 'productos', arguments: producto ),
            ),
          ],
        ),
      )
    );
  }

}