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
Jawab: MaterialApp merupakan widget high-level di Flutter yang mengatur struktur dasar dari material design app. Berikut adalah beberapa fungsi dari MaterialApp:
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
Jawab: Hot reload adalah fitur yang membantu membantu developer membangun UI, menambahkan fitur, dan memperbaiki bug dengan cepat serta mudah. Hot reload bekerja dengan menyisipkan updated source code ke dalam Dart runtime. Setelah Dart runtime meng-update versi kelas terbaru, Flutter secara otomatis akan membangun ulang widget tree sehingga perubahan bisa terlihat

Perbedaan dengan hot restart: hot reload tidak perlu restart the entire app, sedangkan hot restart perlu membersihkan app state terlebih dahulu kemudian memulainya kembali dari awal (re-initializes the app)