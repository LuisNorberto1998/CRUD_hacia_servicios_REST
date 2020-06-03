import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {
  final String _url = "https://proyect-flutter.firebaseio.com";

  //Insertar productos en la BD
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  //Editar producto
  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  //Obtener registros
  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, producto) {
      final prodTemp = ProductoModel.fromJson(producto);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    print(productos);

    return productos;
  }

  //Borrar registro
  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';

    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }
}
