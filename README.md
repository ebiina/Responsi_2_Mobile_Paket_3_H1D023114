# **Responsi 2 Mobile Paket 3 (H1D023114)**

Aplikasi Flutter untuk inventaris kategori **Buku** di supermarket. Aplikasi ini menggunakan Firebase sebagai backend untuk autentikasi pengguna dan manajemen data inventaris (CRUD).

## Informasi Mahasiswa

| Atribut | Detail |
| :--- | :--- |
| **Nama** | Essay Bina Mukti |
| **NIM** | H1D023114 |
| **Shift Baru** | F |
| **Shift Asal** | H |

---

## 🎥 Video Demo Aplikasi

[(videodemo.mp4)](videodemo.mp4)

**Deskripsi Video:** Video ini mendemonstrasikan seluruh fitur utama aplikasi, termasuk:
1.  Pendaftaran pengguna baru.
2.  Login pengguna yang sudah terdaftar.
3.  Melihat daftar inventaris buku.
4.  Menambah buku baru ke inventaris.
5.  Mengedit detail buku yang sudah ada.
6.  Menghapus buku dari inventaris.
7.  Logout dari akun.

---

## 🔧 Spesifikasi API yang Digunakan

Aplikasi ini menggunakan **Firebase** sebagai backend-as-a-service (BaaS) untuk mengelola data dan autentikasi.

### Layanan Firebase

1.  **Firebase Authentication**
    *   **Fungsi:** Mengelola autentikasi pengguna.
    *   **Metode Login:** Email dan Password.
    *   **Fitur:** Registrasi, Login, dan Logout.

2.  **Cloud Firestore**
    *   **Fungsi:** Database NoSQL real-time untuk menyimpan data inventaris buku.
    *   **Operasi:** Create, Read, Update, Delete (CRUD).

### Struktur Data Firestore

Data buku disimpan dalam sebuah koleksi bernama `books`.

*   **Collection:** `books`
*   **Document ID:** Auto-generated ID oleh Firestore
*   **Fields (Kolom):**

| Field | Tipe Data | Contoh |
| :--- | :--- | :--- |
| `judul` | String | "Laskar Pelangi" |
| `harga` | Integer | 99000 |
| `jumlah` | Integer | 50 |
| `tanggal_masuk` | String | "2023-10-27" |
| `volume` | Integer | 500 |
| `penulis` | String | "Andrea Hirata" |
| `penerbit` | String | "Bentang Pustaka" |

---

## 📄 Penjelasan Kode untuk Tiap Fungsi

Berikut adalah penjelasan singkat untuk setiap file utama dalam struktur proyek ini.

### `lib/main.dart`

*   **Fungsi:** Titik masuk aplikasi, menginisialisasi Firebase, dan menangani routing utama berdasarkan status autentikasi.
*   **Penjelasan Singkat:**
    *   `Firebase.initializeApp()`: Menginisialisasi koneksi ke proyek Firebase.
    *   `AuthWrapper`: Widget yang menggunakan `StreamBuilder` untuk mendengarkan perubahan status login pengguna (`FirebaseAuth.instance.authStateChanges()`). Jika pengguna sudah login, akan menampilkan `BookListScreen`. Jika belum, akan menampilkan `LoginScreen`.
    *   `MaterialApp`: Mengatur tema aplikasi (warna coklat), judul, dan halaman awal (`home`).

### `lib/models/book.dart`

*   **Fungsi:** Model data (data class) yang merepresentasikan satu buku.
*   **Penjelasan Singkat:**
    *   Mendefinisikan properti buku sesuai spesifikasi (`judul`, `harga`, dll.).
    *   `toMap()`: Mengubah objek `Book` menjadi `Map<String, dynamic>` agar dapat disimpan ke Firestore.
    *   `fromMap()`: Fungsi factory yang membuat objek `Book` dari `Map` yang didapat dari Firestore.

### `lib/services/auth_service.dart`

*   **Fungsi:** Layanan (service) yang menangani semua logika bisnis terkait autentikasi pengguna.
*   **Penjelasan Singkat:**
    *   `registerWithEmailAndPassword()`: Memanggil fungsi `createUserWithEmailAndPassword` dari Firebase Auth untuk mendaftarkan pengguna baru.
    *   `signInWithEmailAndPassword()`: Memanggil fungsi `signInWithEmailAndPassword` dari Firebase Auth untuk login pengguna.
    *   `signOut()`: Memanggil fungsi `signOut` dari Firebase Auth untuk keluar dari sesi.
    *   `userStream`: Mengembalikan stream yang dapat didengarkan oleh UI untuk merespons secara real-time terhadap perubahan status login.

### `lib/services/book_service.dart`

*   **Fungsi:** Layanan yang menangani semua operasi CRUD (Create, Read, Update, Delete) untuk data buku di Firestore.
*   **Penjelasan Singkat:**
    *   `addBook()`: Menambahkan dokumen buku baru ke koleksi `books`.
    *   `getBooks()`: Mengambil stream dari koleksi `books`. Stream ini memungkinkan UI untuk diperbarui secara otomatis saat ada perubahan data (real-time).
    *   `updateBook()`: Memperbarui data dokumen buku yang ada berdasarkan ID-nya.
    *   `deleteBook()`: Menghapus dokumen buku dari koleksi berdasarkan ID-nya.

### `lib/screens/login_screen.dart`

*   **Fungsi:** Tampilan (UI) untuk halaman login pengguna.
*   **Penjelasan Singkat:**
    *   Menampilkan `Form` dengan `TextFormField` untuk input email dan password.
    *   Memuat data ke `AuthService.signInWithEmailAndPassword()` saat tombol login ditekan.
    *   Menampilkan `SnackBar` untuk notifikasi error (misal: "Email atau password salah").
    *   Menyediakan navigasi ke halaman registrasi bagi pengguna baru.

### `lib/screens/register_screen.dart`

*   **Fungsi:** Tampilan (UI) untuk halaman registrasi pengguna baru.
*   **Penjelasan Singkat:**
    *   Mirip dengan `LoginScreen`, tetapi memanggil `AuthService.registerWithEmailAndPassword()`.
    *   Menampilkan notifikasi sukses atau gagal setelah proses pendaftaran.

### `lib/screens/book_list_screen.dart`

*   **Fungsi:** Tampilan utama yang menampilkan daftar semua buku dari Firestore (operasi **Read**).
*   **Penjelasan Singkat:**
    *   Menggunakan `StreamBuilder` yang terhubung ke `BookService.getBooks()` untuk menampilkan data secara real-time.
    *   Menampilkan buku dalam `ListView`. Setiap item menampilkan judul dan penulis.
    *   Setiap item memiliki ikon untuk **edit** (navigasi ke `BookFormScreen` dengan data buku) dan **delete** (menampilkan dialog konfirmasi dan memanggil `BookService.deleteBook()`).
    *   Memiliki `FloatingActionButton` untuk menavigasi ke `BookFormScreen` kosong untuk menambah buku baru.

### `lib/screens/book_form_screen.dart`

*   **Fungsi:** Tampilan (UI) untuk menambah buku baru (**Create**) dan mengedit buku yang ada (**Update**).
*   **Penjelasan Singkat:**
    *   Menerima objek `Book` opsional melalui parameter konstruktor. Jika objek ada, form akan diisi dengan datanya (mode edit). Jika `null`, form kosong (mode tambah).
    *   Menampilkan `Form` dengan `TextFormField` untuk semua field buku (`judul`, `harga`, dll.).
    *   Melakukan validasi input (misal: harga dan jumlah harus berupa angka).
    *   Saat disimpan, akan memanggil `BookService.addBook()` (mode tambah) atau `BookService.updateBook()` (mode edit).

---

## 🛠 Teknologi yang Digunakan

*   **Framework:** [Flutter](https://flutter.dev/)
*   **Bahasa Pemrograman:** [Dart](https://dart.dev/)
*   **Backend:** [Firebase](https://firebase.google.com/)
    *   Authentication
    *   Cloud Firestore