import 'package:flutter/material.dart';

import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    print('pasa por el crear listado');

    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i]),
          
          );

        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ) {
        productosProvider.borrarProducto(producto.id);
      },
      child: ListTile(
        title: Text('${ producto.titulo } - ${ producto.valor }'),
        subtitle: Text( producto.id ),
        onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto)
                      .then((value) => setState(() {})),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto').then((value) => setState(() {}))
    );
  }
}