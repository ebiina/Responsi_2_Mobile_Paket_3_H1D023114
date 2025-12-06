class Book {
  final String? id; // ID dokumen dari Firestore
  final String judul;
  final int harga;
  final int jumlah;
  final String tanggalMasuk;
  final int volume;
  final String penulis;
  final String penerbit;

  Book({
    this.id,
    required this.judul,
    required this.harga,
    required this.jumlah,
    required this.tanggalMasuk,
    required this.volume,
    required this.penulis,
    required this.penerbit,
  });

  // Fungsi untuk mengubah objek Book menjadi Map (untuk disimpan ke Firestore)
  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'harga': harga,
      'jumlah': jumlah,
      'tanggal_masuk': tanggalMasuk,
      'volume': volume,
      'penulis': penulis,
      'penerbit': penerbit,
    };
  }

  // Fungsi factory untuk membuat objek Book dari Map (dari Firestore)
  factory Book.fromMap(String id, Map<String, dynamic> map) {
    return Book(
      id: id,
      judul: map['judul'] ?? '',
      harga: map['harga']?.toInt() ?? 0,
      jumlah: map['jumlah']?.toInt() ?? 0,
      tanggalMasuk: map['tanggal_masuk'] ?? '',
      volume: map['volume']?.toInt() ?? 0,
      penulis: map['penulis'] ?? '',
      penerbit: map['penerbit'] ?? '',
    );
  }
}