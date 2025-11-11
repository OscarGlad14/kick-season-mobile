import 'package:flutter/material.dart';
import 'package:kick_season/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    String _description = "";
    String _category = "sepatu"; // default
    String _thumbnail = "";
    String _brand = "";
    int _stock = 0;
    int _price = 0;
    DateTime _createdat = DateTime.now(); // default
    bool _isFeatured = false; // default
    
    final List<String> _categories = [
      'sepatu',
      'pakaian',
      'aksesoris',
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Form Tambah Produk',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          drawer: LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if(value == null || value.isEmpty){
                      return "URL thumbnail harus diisi";
                    }
                    final uri = Uri.tryParse(value);
                    if(uri == null || !uri.hasAbsolutePath){
                      return "URL thumbnail tidak valid";
                    }
                    return null;
                  },
                ),
              ),

              // === Nama Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk harus diisi";
                    }
                    if (value.length <= 4){
                      return "Nama produk terlalu singkat";
                    }
                    if (value.length == 255){
                      return "Nama produk telah mencapai batas maksimal";
                    }
                    if (value.length > 255){
                      return "Nama produk terlalu panjang. Hapus menjadi 255 karakter agar valid";
                    }
                    return null;
                  },
                ),
              ),

              // === Brand Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Brand Produk",
                    labelText: "Brand Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _brand = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Brand produk harus diisi";
                    }
                    if(value.length <= 2){
                      return "Brand produk terlalu singkat";
                    }
                    if(value.length == 255){
                      return "Brand produk telah mencapai batas maksimal";
                    }
                    if(value.length > 255){
                      return "Brand produk terlalu panjang. Hapus menjadi 255 karakter agar valid";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Produk",
                    labelText: "Deskripsi Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi produk harus diisi";
                    }
                    if (value.length < 20) {
                      return "Deskripsi produk terlalu singkat";
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(
                                cat[0].toUpperCase() + cat.substring(1)),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Stok Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Stok",
                    labelText: "Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      final parsed = int.tryParse(value);
                      if(parsed != null){
                        _stock = parsed;
                      }
                    });
                  },
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Stok harus diisi";
                    }

                    final stokInInt = int.tryParse(value);
                    if(stokInInt == null){
                      return "Stok harus berupa angka";
                    }
                    if(stokInInt <= 0){
                      return "Stok harus bernilai positif";
                    }
                    return null;
                  },
                ),
              ),
              
              // === Harga Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      final parsed = int.tryParse(value);
                      if(parsed != null){
                        _price = parsed;
                      }
                    });
                  },
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Harga harus diisi";
                    }

                    final hargaInInt = int.tryParse(value);
                    if(hargaInInt == null){
                      return "Harga harus berupa angka";
                    }
                    if(hargaInInt <= 0){
                      return "Harga harus bernilai positif";
                    }
                    return null;
                  },
                ),
              ),

              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil ditambahkan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Produk: $_name'),
                                    Text('Brand: $_brand'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: $_category'),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                    Text('Stok: $_stock'),
                                    Text('Harga: $_price'),
                                    Text('Dibuat pada: $_createdat'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      // Reset secara menual beberapa variabel
                                      _category = "sepatu";
                                      _isFeatured = false;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ],
              ),
            ),
          ),
        );
    }
}

