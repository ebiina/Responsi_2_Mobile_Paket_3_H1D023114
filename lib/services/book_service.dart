// lib/services/book_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookService {
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('books');

  // Tambah buku baru
  Future<void> addBook(Book book) async {
    await _booksCollection.add(book.toMap());
  }

  // Baca semua buku (stream untuk real-time update)
  Stream<List<Book>> getBooks() {
    return _booksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Update buku
  Future<void> updateBook(String id, Book book) async {
    await _booksCollection.doc(id).update(book.toMap());
  }

  // Hapus buku
  Future<void> deleteBook(String id) async {
    await _booksCollection.doc(id).delete();
  }
}