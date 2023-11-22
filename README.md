# ZAMART MOBILE

> **Naufal Aulia - 2206082455 - PBP E**

## Tugas 7

### Perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

| Perbedaan | StatelessWidget | StatefulWidget |
|---|--|---|
| **Keadaan Internal**    | Tidak memiliki keadaan internal.               | Memiliki keadaan internal yang dapat diubah.               |
| **Render**              | Merender tampilan statis, tidak dapat diubah.  | Dapat merender ulang tampilan saat terjadi perubahan state.|
| **Pengulangan Render**  | Tidak akan merender ulang dirinya sendiri.     | Akan merender ulang dirinya sendiri saat ada perubahan.    |
| **Method `setState()`** | Tidak memiliki method `setState()`.            | Memiliki method `setState()` untuk mengubah state.         |
| **Contoh Penggunaan**   | Tampilan yang tidak perlu berubah, data statis.| Input pengguna, data dinamis, perubahan tampilan.          |
| **Kapan Digunakan**     |   Efisien untuk tampilan statis.               | Saat perlu mengelola perubahan state atau data.            |

Ketika memilih antara `StatelessWidget` dan `StatefulWidget`, pertimbangkan kebutuhan spesifik proyek. `StatelessWidget` cocok untuk tampilan statis dan efisien, sedangkan `StatefulWidget` digunakan untuk mengelola tampilan yang dapat berubah dan berinteraksi dengan perubahan state.

### Seluruh widget yang digunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

* `Scaffold` berfungsi sebagai struktur dasar untuk tampilan halaman.
* `AppBar` berfungsi menampilkan header aplikasi dengan judul.
* `SingleChildScrollView` berfungsi menampilkan suatu widget yang isinya dapat di-scroll.
* `Padding` berfungsi untuk memberikan padding pada konten.
* `Column` berfungsi menampilkan _children_ secara vertikal.
* `GridView` berfungsi menampilkan  _children_ dengan layout grid.
* `ItemCard` sebuah stateless widget yang berisi widget-widget lain untuk membentuk suatu kesatuan card yang digunakan sebagai template.
* `Material` berfungsi untuk memberikan desain kepada child berdasarkan desain dari Material Design.
* `InkWell` berfungsi untuk memberikan sentuhan responsif pada child.
* `SnackBar` berfungsi untuk menampilkan pesan singkat di bagian bawah layar.
* `Container` berfungsi untuk mengatur tata letak, style, dan property pada child.
* `Center` berfungsi untuk membuat posisi child pada tengah.
* `Icon` berfungsi untuk menampilkan ikon.

### Implementasi _checklist_ dari awal sampai akhir

1. Pergi ke direktori dimana aplikasi ini ingin dibuat, lalu buka command prompt pada direktori tersebut.
2. _Generate_ proyek Flutter baru dengan nama `zamart`, kemudian masuk ke dalam direktori proyek tersebut dengan menjalankan kode   `flutter create zamart` --> `cd zamart`.
3. Membuat file baru dengan nama `menu.dart` pada direktori `lib` dan tambahkan baris `import 'package:flutter/material.dart';`
4. Memindahkan kode pada file `main.dart` pada bagian  class `MyHomePage` dan `_MyHomePage` ke file `menu.dart`.
5. Menambahkan baris `import 'package:inventory_manager/menu.dart';` kedalam file `main.dart` agar kelas `MyHomePage` dapat digunakan pada `main.dart`. 
6. Mengubah sifat widget MyHomePage menjadi stateless dengan mengubah kode pada class MyHomePage menjadi seperti berikut.
    ```dart
    class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(

        )
    ```
7. Mengubah baris kode `MyHomePage(title: 'Flutter Demo Home Page')` pada file `main.dart` menjadi `MyHomePage()`.
8. Membuat class item, dan menambahkan atribut color (soal bonus).
    ```dart
    class Item {
        final String name;
        final IconData icon;
        final Color color;

        Item(this.name, this.icon, this.color);
        }
    ```
9. Menambahkan baris kode berikut untuk menambahkan item-item yang akan dibuat di bawah constructor pada class `MyHomePage`.
    ```dart
    final List<ShopItem> items = [
      ShopItem("Lihat Item", Icons.checklist, Color(0xFFEA9085)),
      ShopItem("Tambah Item", Icons.add_shopping_cart, Color(0xFF6E5773)),
      ShopItem("Logout", Icons.logout, Color(0xFF4F323B)),
    ];
    ```

10. Menambahkan kode berikut di dalam Widget build pada class MyHomePage.
    ```dart
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFE9E2D0),
            title: const Text(
              'ZaMart',
            ),
          ),
          body: SingleChildScrollView(
            // Widget wrapper yang dapat discroll
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Set padding dari halaman
              child: Column(
                // Widget untuk menampilkan children secara vertikal
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                    child: Text(
                      'ZaMart Inventory', // Text yang menandakan toko
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Grid layout
                  GridView.count(
                    // Container pada card kita.
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ShopItem item) {
                      // Iterasi untuk setiap item
                      return ShopCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
    ```

11. Membuat _stateless_ widget `ItemCard` untuk menampilkan card.
    ```dart
    class ShopCard extends StatelessWidget {
        final ShopItem item;

        const ShopCard(this.item, {super.key}); // Constructor

        @override
        Widget build(BuildContext context) {
            return Material(
            color: item.color, // Menggunakan warna dari variabel buttonColor
            child: InkWell(
                // Area responsive terhadap sentuhan
                onTap: () {
                // Memunculkan SnackBar ketika diklik
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}!")));
                },
                child: Container(
                // Container untuk menyimpan Icon dan Text
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                        item.icon,
                        color: Colors.white,
                        size: 30.0,
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        ),
                    ],
                    ),
                ),
                ),
            ),
            );
        }
    }
    ```

12. Menghapus class `_MyHomePage` karena widget `MyHomePage` sudah berubah menjadi stateless sehingga class` _MyHomePage` tidak dibutuhkan.

# Tugas 8

### Perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

  Navigator.push() dan Navigator.pushReplacement() adalah dua metode yang digunakan untuk menavigasi antar halaman (routes) dalam aplikasi Flutter. Berikut adalah perbedaan antara keduanya:
  - Navigator.push()
    - Menggunakan metode ini untuk menambahkan halaman baru ke dalam tumpukan navigasi.
    - Tumpukan navigasi akan menahan semua halaman sebelumnya.
    - Ketika kembali dari halaman yang ditambahkan, maka kembali ke halaman sebelumnya di tumpukan.
    - Contoh:
      ```dart
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ShopFormPage()));
      ```
  - Navigator.pushReplacement()
    - Menggantikan halaman saat ini dengan halaman baru.
    - Tumpukan navigasi tetap memiliki panjang yang sama setelah navigasi.
    - Cocok digunakan ketika ingin menggantikan halaman yang sudah ada dengan halaman baru.
    - Contoh:
      ```dart
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const ShopFormPage()));
      ```


### Layout widget pada Flutter dan konteks penggunaannya masing-masing!

* `Container` digunakan untuk mengelilingi dan menyesuaikan elemen-elemen lain. Container sering digunakan untuk mengatur margin, padding, dan dekorasi.
* `Row` digunakan untuk menempatkan widget sejajar secara horizontal.
* `Column` digunakan untuk menempatkan widget secara vertikal.
* `ListView` digunakan untuk menampilkan daftar elemen secara berurutan, baik secara horizontal atau vertikal.
* `Stack` digunakan untuk menumpuk widget di atas satu sama lain.
* `Expanded` digunakan untuk memberikan widget parent ruang tambahan yang tersedia dalam arah tertentu.
* `GridView` digunakan untuk menampilkan elemen dalam susunan grid.
* `Card` digunakan untuk membuat kotak yang bisa berisi teks, gambar, atau widget lainnya.
* `SizedBox` digunakan untuk memberikan dimensi tertentu pada widget.
* `Warp` digunakan untuk membungkus widget yang dapat berukuran besar dan memindahkannya ke baris berikutnya jika tidak muat.

### Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

Dalam tugas ini, terdapat beberapa elemen input pada form. Elemen input yang digunakan melibatkan pengguna untuk memasukkan data atau informasi tertentu. Elemen input yang digunakan pada tugas ini adalah `TextFormField`. Pada tugas ini, `TextFormField` digunakan pada tiga input yaitu "Nama Item", "Harga", dan "Deskripsi". Dalam `TextFormField` juga ditambahkan beberapa validator untuk memastikan input yang diberikan oleh pengguna sesuai dengan input form masing-masing. Penggunaan `TextFormField` memberikan fleksibilitas, validasi, dan respons yang dibutuhkan dalam hal ini.

### Bagaimana penerapan clean architecture pada aplikasi Flutter?

Clean architecture adalah pola desain perangkat lunak yang membantu para deloveper menulis kode yang dapat dipelihara dan dapat di-scale. Dengan memisahkan lapisan presentasi, lapisan domain, dan lapisan data, developer dimudahkan untuk memodifikasi dan memperluas kode tanpa menambahkan kompleksitas yang tidak perlu. Salah satu contoh penerapan clean architecture pada flutter adalah dengan membuat direktori yang membedakan file dart untuk widget, screen, dan sebagainya.

### Implementasi _checklist_ dari awal sampai akhir
1. Membuat file item_form.dart serta mengisi dengan form yang memiliki input untuk nama, kategori, jumlah, harga, dan deskripsi. 
2. Membuat file item_card.dart dan melakukan cut pada kode tentang ShopCard pada menu.dart ke item_card.
3. Membuat sebuah class item pada item_card.dart untuk mendefinisikan item yang di save pada item_form.dart.
4. Membuat sebuah array pada file item_form.dart untuk menyimpan item yang di-save pada form.
5. Membuat file item_list.dart serta mengisi dengan kode yang dapat menampilkan item yang di-save pada item_form.dart
6. Membuat file left_drawer.dart dan mengisinya dengan drawer yang bisa navigasi ke home, item_form, dan item_list.
7. Membuat dua direktori baru pada direktori lib, yaitu widgets dan screens.
8. Memindahkan file item_card.dart dan left_drawer.dart ke direktori widgets dan lakukan refaktor kode (dilakukan secara otomatis oleh ekstensi).
9. Memindahkan file item_form.dart, item_list.dart, dan menu.dart ke direktori screens dan lakukan refaktor kode (dilakukan secara otomatis oleh ekstensi).

# Tugas 9

### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Bisa, pengambilan data tanpa menggunakan model (parsing dinamis) memiliki kelebihan dan kekurangan yang masing-masing. Kelebihannya terletak pada fleksibilitasnya dan penyederhanaan kode. Namun, kekurangannya mencakup ketidakpastian dalam tipe data, kemunculan error yang hanya terlihat saat kode dieksekusi, dan kesulitan dalam proses debugging. Menurut pendapat saya, pengambilan data tanpa model lebih sesuai digunakan ketika mengambil data dari API yang memiliki respons dengan struktur dinamis dan sulit untuk dimodelkan. Namun, dalam konteks tugas ini, lebih disarankan untuk menggunakan pendekatan pembuatan model karena dapat mengatasi kelemahan dari pengambilan data tanpa model, meskipun memerlukan tambahan kode yang cukup signifikan. Selain itu, respons dari API dalam konteks tugas ini juga sudah ditetapkan atau konsisten.

### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

CookieRequest adalah kelas yang digunakan untuk mengelola cookie di aplikasi Flutter. Kelas ini menyediakan metode untuk menambahkan, menghapus, dan memeriksa cookie.Fungsi utama dari CookieRequest adalah untuk menyimpan cookie dari server web. Cookie ini kemudian dapat digunakan untuk autentikasi pengguna, menyimpan preferensi pengguna, atau untuk tujuan lainnya. Instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter agar semua komponen dapat mengakses cookie yang sama. Hal ini penting untuk aplikasi yang menggunakan cookie untuk autentikasi pengguna, karena semua komponen perlu memiliki akses ke cookie pengguna untuk memverifikasi autentikasi pengguna.

### Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

1. Menambahkan dependensi http ke proyek; dependensi ini digunakan untuk bertukar HTTP request.
2. Membuat model sesuai dengan respons dari data yang berasal dari web service tersebut.
3. Membuat http request ke web service menggunakan dependensi http.
4. Mengkonversikan objek yang didapatkan dari web service ke model yang telah kita buat di langkah kedua.
5. Menampilkan data yang telah dikonversi ke aplikasi dengan FutureBuilder.
6. JSON difetch ke sesuai urlnya dengan header json
7. JSON yang telah difetch akan disesuaikan bodynya menuju model Item sesuai dengan properti-properti yang ada.

### Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

1. Flutter menampilkan form untuk mengisi data login.
2. Setelah data diinput dan menekan tombol login, flutter melakukan http request ke Django untuk login dengan data yang sudah diinput.
4. Django akan melakukan proses login dan memberikan respons sesuai keberhasilan login
5. Jika berhasil login maka flutter akan melakukan navigasi ke menu

### Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.

1. `FutureBuilder` digunakan untuk menangani hasil dari suatu Future tanpa harus secara eksplisit menangani pengelolaannya. Future disini berguna untuk melakukan operasi asinkron dan salah satu contoh yang dipakai adalah melakukan request ke server.
2. `ListView` digunakan untuk menampilkan data secara berurutan.
3. `InkWell` digunakan untuk menambahkan efek respons saat widget tersebut ditekan.
4. `SizedBox` digunakan untuk menentukan ukuran dari suatu ruang kosong.
5. `Text` digunakan untuk menampilkan teks.
6. `Column` digunakan untuk menyusun dan menampilkan child widget secara vertikal.
7. `ShopCard` digunakan sebagai button atau card untuk menunjukkan hal yang dapat dilakukan.
8. `LeftDrawer` digunakan sebagai widget untuk menampilkan drawer.
9. `Drawer` digunakan sebagai tempat drawer di sisi kiri halaman yang berupa menu/navigasi.
10. `Form` digunakan sebagai wadah bagi beberapa input field widget.
11. `TextFormField` digunakan untuk menampilkan input teks.
12. `SingleChildScrollView` digunakan untuk membuat child widget di dalamnya menjadi scrollable jika melebihi ukuran layar.
13. `ElevatedButton` adalah Tombol yang memiliki efek elevation ketika ditekan.
14. `AlertDialog` digunakan untuk menampilkan alert dialog atau seperti modal.

### Implementasi _checklist_ dari awal sampai akhir

1. Menambahkan app baru pada Django, yaitu authentication untuk melakukan autentikasi dan menambah view untuk melakukan proses penambahan data.
2. Install package provider dan pbp_django_auth.
3. Membuat objek Provider yang berfungsi membagikan instance CookieRequest ke semua komponen.
4. Membuat halaman login yang meminta input username dan password serta melakukan request ke url auth/login/ untuk melakukan proses autentikasi.
5. Membuat model item yang berfungsi sebagai pemrosesan respons server agar dapat ditampilkan ke UI dan pemrosesan data input untuk melakukan request ke server.
6. Membuat halaman item_list yang berfungsi untuk menampilkan semua item yang ada (fetch ke server). Tiap item hanya menampilkan name, amount, price, description, dan category.
7. Melakukan routing pada left drawer dan menu ke item list.
8. Integrasi item form dengan API untuk menambahkan data ke server.
9. Melakukan aksi logout jika menu logout ditekan.