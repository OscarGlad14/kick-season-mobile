import 'package:flutter/material.dart';
import 'package:kick_season/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:kick_season/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends  State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    String _description = "";
    String _category = "sepatu"; // default
    String _thumbnail = "";
    String _brand = "";
    int _stock = 0;
    int _price = 0;
    bool _isFeatured = false; // default
    
    final List<String> _categories = [
      'sepatu',
      'pakaian',
      'aksesoris',
    ];

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
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
                    if (value.length < 4){
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
                    if(value.length < 2){
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {                        
                        final response = await request.postJson(
                          "https://oscar-glad-footballnews.pbp.cs.ui.ac.id/create-flutter/",
                          jsonEncode({
                            "name": _name,              // ✅ FIXED: Ganti dari "title"
                            "brand": _brand,
                            "description": _description, // ✅ FIXED: Ganti dari "content"
                            "price": _price,
                            "stock": _stock,
                            "thumbnail": _thumbnail,
                            "category": _category,
                            "is_featured": _isFeatured,
                            // ✅ FIXED: Hapus "created_at"
                          }),
                        );
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Produk berhasil disimpan!"), // ✅ FIXED: Ganti pesan
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Terjadi kesalahan, coba lagi."),
                            ));
                          }
                        }
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