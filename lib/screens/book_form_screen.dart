// lib/screens/book_form_screen.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookFormScreen extends StatefulWidget {
  final Book? book; // Jika tidak null, ini mode edit

  const BookFormScreen({super.key, this.book});

  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _volumeController = TextEditingController();
  final _penulisController = TextEditingController();
  final _penerbitController = TextEditingController();

  final BookService _bookService = BookService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Jika ada data buku, isi form dengan data tersebut (mode edit)
    if (widget.book != null) {
      _judulController.text = widget.book!.judul;
      _hargaController.text = widget.book!.harga.toString();
      _jumlahController.text = widget.book!.jumlah.toString();
      _tanggalController.text = widget.book!.tanggalMasuk;
      _volumeController.text = widget.book!.volume.toString();
      _penulisController.text = widget.book!.penulis;
      _penerbitController.text = widget.book!.penerbit;
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _hargaController.dispose();
    _jumlahController.dispose();
    _tanggalController.dispose();
    _volumeController.dispose();
    _penulisController.dispose();
    _penerbitController.dispose();
    super.dispose();
  }

  Future<void> _saveBook() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final newBook = Book(
        judul: _judulController.text,
        harga: int.parse(_hargaController.text),
        jumlah: int.parse(_jumlahController.text),
        tanggalMasuk: _tanggalController.text,
        volume: int.parse(_volumeController.text),
        penulis: _penulisController.text,
        penerbit: _penerbitController.text,
      );

      if (widget.book == null) {
        // Mode Tambah
        await _bookService.addBook(newBook);
      } else {
        // Mode Update
        await _bookService.updateBook(widget.book!.id!, newBook);
      }

      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Tambah Buku' : 'Edit Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _judulController,
                  decoration: const InputDecoration(labelText: 'Judul Buku'),
                  validator: (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
                ),
                TextFormField(
                  controller: _penulisController,
                  decoration: const InputDecoration(labelText: 'Penulis'),
                  validator: (value) => value!.isEmpty ? 'Penulis tidak boleh kosong' : null,
                ),
                TextFormField(
                  controller: _penerbitController,
                  decoration: const InputDecoration(labelText: 'Penerbit'),
                  validator: (value) => value!.isEmpty ? 'Penerbit tidak boleh kosong' : null,
                ),
                TextFormField(
                  controller: _hargaController,
                  decoration: const InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Harga tidak boleh kosong';
                    if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _jumlahController,
                  decoration: const InputDecoration(labelText: 'Jumlah Stok'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Jumlah tidak boleh kosong';
                    if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _volumeController,
                  decoration: const InputDecoration(labelText: 'Volume (Halaman)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Volume tidak boleh kosong';
                    if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tanggalController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Masuk (YYYY-MM-DD)',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                          _tanggalController.text = formattedDate;
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Tanggal tidak boleh kosong';
                    // Validasi format YYYY-MM-DD bisa ditambahkan di sini
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _saveBook,
                        child: Text(widget.book == null ? 'Simpan' : 'Perbarui'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}