import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:zamart/main.dart';
import 'package:zamart/screens/menu.dart';
import 'package:zamart/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
    const ShopFormPage({super.key});

    @override
    State<ShopFormPage> createState() => _ShopFormPageState();
}


class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    String _category = "";
    int _amount = 0;
    int _price = 0;
    String _description = "";

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Form Tambah Item',
              ),
            ),
            backgroundColor: Color(0xFF6E5773),
            foregroundColor: Colors.white,
          ),
          drawer: const LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nama Item",
                          labelText: "Nama Item",
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
                            return "Nama tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Kategori",
                          labelText: "Kategori",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _category = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Kategori tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Jumlah",
                          labelText: "Jumlah",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _amount = int.parse(value!);
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Jumlah tidak boleh kosong!";
                          }
                          if (int.tryParse(value) == null) {
                            return "Jumlah harus berupa angka!";
                          }
                          return null;
                        },
                      ),
                    ),
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
                        onChanged: (String? value) {
                          setState(() {
                            _price = int.parse(value!);
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Harga tidak boleh kosong!";
                          }
                          if (int.tryParse(value) == null) {
                            return "Harga harus berupa angka!";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Deskripsi",
                          labelText: "Deskripsi",
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
                            return "Deskripsi tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
                    ),
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
                              // Kirim ke Django dan tunggu respons
                              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                              final response = await request.postJson(
                              "http://127.0.0.1:8000/create-flutter/",
                              jsonEncode(<String, String>{
                                  'name': _name,
                                  'amount': _amount.toString(),
                                  'price': _price.toString(),
                                  'description': _description,
                                  'category' : _category,
                                  // TODO: Sesuaikan field data sesuai dengan aplikasimu
                              }));
                              if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                  content: Text("Produk baru berhasil disimpan!"),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyHomePage()),
                                  );
                              } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content:
                                          Text("Terdapat kesalahan, silakan coba lagi."),
                                  ));
                              }
                            // _formKey.currentState!.reset();
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
              )
            ),
          ),
        );
    }
}