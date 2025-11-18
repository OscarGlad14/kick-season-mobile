# Tugas 7 

## 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Jawab:
Widget tree pada flutter merupakan struktur hierarkis yang merepresentasikan hubungan antara parent-child. Setiap widget akan dibuat menjadi node, dimana bagian atas disebut parent dan anak dari parent merupakan child.

Hubungan parent child:
Parent -> mengatur tata letak serta behaviour child yang dimiliki
Child -> mewarisi konteks dari parent dan dapat menggunakan style yang disediakan oleh parent

## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
Jawab:
Scaffold : berfungsi sebagai struktur dasar halaman aplikasi
AppBar : berfungsi untuk menampilkan judul di halaman atas
Padding : berfungsi untuk memberikan jarak di sekitar widget
Row : berfungsi untuk mengatur widget secara horizontal
Column : berfungsi untuk mengatur widget secara vertikal
SizedBox : berfungsi untuk memberikan jarak secara vertikal atau horizontal antar widget
Center : berfungsi untuk menempatkan widget anaknya tepat di tengah layar

## 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
Jawab:
MaterialApp merupakan widget high-level di Flutter yang mengatur struktur dasar dari material design app. Berikut adalah beberapa fungsi dari MaterialApp:
1. Menentukan tema global (contoh: warna, font, dll)
2. Mengatur navigasi antar halaman
3. Menyediakan localization dan title aplikasi
4. Menjadi root context untuk seluruh widget di bawahnya.

## 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
Jawab:
Perbedaan
Stateless -> Tidak memiliki state yang bisa berubah atau UI-nya tetap selama aplikasi dijalankan
Stateful -> Memiliki state yang bisa berubah selama aplikasi dijalankan

Kapan sebaiknya dipilih
Stateless -> dipilih ketika tampilan yang dibuat bersifat statis--tampilan tidak berubah selama aplikasi berjalan
Stateful -> dipilih ketika tampilan cenderung berubah-ubah berdasarkan interaksi pengguna dan data

## 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
Jawab:
BuildContext merupakan objek yang menyimpan informasi posisi suatu widget dalam widget tree. Dengan BuildContext, kita dapat mengakses warna, tema, ukuran layar, dan hal lain yang telah disediakan oleh widget parent

Cara penggunaan: Ketika memanggil method build, Flutter secara otomatis akan menyediakan BuildContext yang bisa kita gunakan untuk mengakses warna, tema, dan beberapa hal lain dari widget parent

## 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Jawab:
Hot reload adalah fitur yang membantu membantu developer membangun UI, menambahkan fitur, dan memperbaiki bug dengan cepat serta mudah. Hot reload bekerja dengan menyisipkan updated source code ke dalam Dart runtime. Setelah Dart runtime meng-update versi kelas terbaru, Flutter secara otomatis akan membangun ulang widget tree sehingga perubahan bisa terlihat

Perbedaan dengan hot restart: hot reload tidak perlu restart the entire app, sedangkan hot restart perlu membersihkan app state terlebih dahulu kemudian memulainya kembali dari awal (re-initializes the app)

# Tugas 8
## 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Jawab:
Perbedaan: .push() bekerja dengan cara menambah route/halaman baru di atas stack (tidak menghapus yg sebelumnya), sedangkan pushreplacement() menghapus route/halaman terakhir kemudian mengganti dengan halaman yang baru (halaman sebelummnya hilang dari stack).

.push() cocok digunakan ketika user berpindah ke suatu halaman dan masih bisa kembali ke halaman sebelumnya (misalnya dengan button back), sedangkan .pushreplacement() cocok digunakan ketika user berpindah dan tidak bisa kembali ke halaman sebelumnya.

## 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Jawab:
- Scaffold: saya menggunakannya sebagai struktur dasar untuk seluruh halaman sehingga setiap page memiliki layout yang sama untuk menjaga konsistensi
- AppBar: saya menggunakannya untuk menampilkan judul di setiap page dengan menyesuaikan style text serta bg color yang digunakan untuk menjaga konsistensi
- Drawer: saya membuat satu blok kode yang berfungsi untuk membuat drawer, kemudian memasukkan drawer tersebut ke setiap halaman yang membutuhkannya dengan cara -> drawer: LeftDrawer(). Dengan cara ini, saya tidak perlu membuat drawer baru di tiap halaman sehingga konsistensi akan lebih terjaga

## 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Jawab:
Kelebihan:
- Padding -> bisa memberikan jarak antara komponen UI sehingga lebih rapi dan mudah dibaca
- SingleChildScrollView -> membuat suatu komponen dapat di-scroll sehingga ketika komponen terlalu panjang, kontennya tetap readable
- ListView -> mempermudah penataan elemen komponen yang memanjang secara vertikal dan secara otomatis memberikan scrolling behaviour sehingga tidak terjadi overflow ketika elemen terlalu panjang

Contoh penggunaan di aplikasi kick season: 
- Padding -> digunakan di setiap komponen yang melibatkan huruf dan kotak (misal di setiap field product form) agar huruf dan kotaknya memiliki jarak yang rapi dan mudah dibaca
- SingleChildScrollView -> membungkus form dan pop up ketika berhasil simpan produk sehingga keduanya tidak mengalami overflow error ketika komponen terlalu panjang
- ListView -> membungkus left drawer secara vertikal

## 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Jawab:
Untuk menjaga identitas visual yang konsisten, saya mendefinisikan ThemeData pada MaterialApp di main.dart dengan menentukan warna utama aplikasi. Kemudian, warna tersebut saya akses pada halaman lain dengan Theme.of(context).colorScheme.primary. Dengan begitu, seluruh halaman aplikasi saya akan memiliki tampilan warna yang seragam

# Tugas 9
## Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Jawab:
Dart merupakan bahasa yang tergolong strongly type. Maka dari itu, kita perlu membuat model Dart untuk mendapatkan representasi yang lebih terstruktur dan memastikan setiap field punya tipe yang jelas. Dengan model juga kita bisa menandai field yang required dan berpotensi null (nullable). Jika langsung memetakan map, bisa saja terjadi invalid type (misal di flutter nya ditulis int, padahal value di map nya String). Lalu, bisa juga terjadi null karena tidak diidentifikasi sebagai nullable. Terakhir, dari segi maintanability juga kurang baik, misal kita mengubah key "product_name" menjadi "name", maka kita harus ubah semua yg mengakses key tersebut secara manual

## Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
Jawab:
Perbedaan peran http dan CookieRequest di tugas ini adalah sebagai berikut.
http berfungsi untuk melakukan http request (GET, POST) dari dan ke project django yang sudah dibuat sebelumnya.
CookieRequest berfungsi untuk mengintegrasikan authentication serta menyimpan cookie dan session antara django dan flutter

## Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Jawab:
Instance CookieRequest perlu dibagikan ke semua kopmponen karena session dan authentication state harus konsisten di seluruh komponen aplikasi. Apabila setiap komponen tidak dibagikan instance CookieRequest dan membuat instance baru, maka yang terjadi adalah login state tidak sinkron

## Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Jawab:
Konfigurasi konektivitas yg diperlukan adalah 10.0.2.2 (flutter) dan localhost:8000 (django). Kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS agar aplikasi bisa berjalan di android emulator (karena andro emulator menggunakan 10.0.2.2 sebagai localhost nya). Lalu, karena flutter dan django berjalan di dua origin berbeda (beda port/domain), maka kita perlu aktifkan CORS agar request antar origin bisa diproses. Pengaturan samesite dibuat none sehingga cookie dikirim dan disimpan pada semua jenis cross-site. Hal ini dibutuhkan agar aplikasi bisa mengakses API di domain berbeda (django). Terakhir, android menerapkan sistem keamanan dimana setiap aplikasi berjalan dalam sandbox yang yang terisolasi. Maka dari itu, kita perlu beri permission secara eksplisit agar dia bisa mengakses jaringan internet

Apabila konfigurasi di atas tidak dilakukan dengan benar, maka proyek django yang sudah dibuat tidak bisa berjalan di android karena host tidak diizinkan. Lalu request yang dikirim dari aplikasi juga secara otomatis ditolak oleh CORS

## Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Jawab:
User input data di form, kemudian data nya akan dikumpulkan lalu diconvert ke JSON dan dikirim ke django melalui CookieRequest. Lalu, data tersebut akan diterima di django (misal di create_flutter_product), divalidasi, lalu disimpan ke database. Berikutnya, akan dikirimkan JSONResponse ke Flutter yang kemudian akan diterima dan dicek. JSON berikutnya diconvert ke model yang didefinisikan di flutter. Terakhir, UI akan diupdate sehingga data tersebut bisa tampil di Flutter

## Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Jawab:
Register:
Pertama, user diminta memasukkan username dan password di form login flutter. Lalu, field tersebut akan dikirim ke django dan divalidasi. Jika valid, django akan membuat objek user dengan username dan password tsb, mengirim JSONResponse ke flutter, dan kemudian flutter akan mengarahkan user ke page login

Login:
Username dan password yang diisi user di form login akan dikirim ke django. Lalu, django akan memeriksa apakah ada objek user dengan username dan password tersebut. Jika ada, JSONResponse akan dikirim ke flutter sekaligus dibuatkan session dan cookie. Terakhir, JSONResponse tadi akan diperiksa oleh flutter, jika statusnya sukses maka user akan diarahkan ke HomePage

Logout:
Ketika klik button logout di aplikasi, flutter akan kirim request ke django. Di django, akan dihapus session dan cookies dari user tersebut. Lalu, django mengirimkan JSONResponse ke flutter. Apabila responnya sukses, maka flutter akan mengeluarkan user dari HomePage

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
Jawab:
Berikut adalah langkah yang saya lakukan untuk menyelesaikan tugas 9:
1. Membuat project bernama authentication di django untuk handling proses autentikasi
2. Menambahkan authentication ke daftar installed apps
3. Menambahkan corsheader ke installed apps beserta middleware nya
4. Menambahkan variabel yang mengatur CORS dan CSRF cookie di settings.py
5. Menambahkan host android emulator ke daftar allowed hosts
6. Membuat fungsi yang menangani proses login, register, logout di views.py project authentication
7. Membuat urls.py di authentication dan mendaftarkan route fungsi login, register, dan logout
8. Mendaftarkan authentication.urls ke kick_season/urls.py
9. Menginstall package pbp_django_auth
10. Memodifikasi child widget menggunakan Provider
11. Membuat login.dart dan register.dart (di file main.dart, ganti agar user pertama kali diarahkan ke page login)
12. Membuat model kustom bernama ProductEntry
13. Memberi permission akses internet ke AndroidManifest.xml
14. Menambahkan endopoint proxy untuk mengatasi CORS (dengan membuat function proxy_image di main/views.py)
15. Membuat card untuk product entry (product_entry_card.dart)
16. Membuat halaman yang menampilkan list product_entry (product_entry_list.dart)
17. Menambahkan navigasi ke product_entry_list di left draawer
18. Menambahkan navigasi ke product_entry_list di button all products (halaman utama)
19. Membuat halaman product_detail.dart
20. Mengintegrasi data di django dengan flutter agar bisa mendapatkan data dari django dan membuat product di flutter
21. Menyesuaikan warna aplikasi flutter dengan yang sudah diterapkan di django