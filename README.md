Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Widget tree adalah struktur tree yang tersusun dari widget–widget dari root hingga leaf. Setiap parent menentukan constraints ke child, child memilih ukuran sesuai constraints, lalu mengembalikan ukuran ke parent. Data dan konfigurasi umumnya “mengalir ke bawah” lewat konstruktor atau mekanisme turunan, sementara event/hasil membalikan ke atas via callback.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
Proyek ini menggunakan MyApp (root) serta widget kustom MyHomePage, ItemCard, dan InfoCard; MaterialApp untuk konfigurasi global aplikasi (tema, routing, akses Material); Scaffold sebagai kerangka layar dengan AppBar di bagian atas; Card dan Material untuk kontainer; widget layout Row, Column, Center, Container, Padding, dan SizedBox untuk mengatur tata letak, ukuran, dan spasi; widget konten Text dan Icon untuk menampilkan teks/ikon; InkWell untuk area sentuh dengan efek ripple; serta SnackBar untuk notifikasi singkat di bagian bawah.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp menyediakan konfigurasi aplikasi tingkat atas: tema, font, routing dan Navigator, localization, MediaQuery, debug banner, dsb. MaterialApp sering jadi root karena membungkus seluruh tree dengan komponen Material yang dibutuhkan banyak widget, sehingga fitur UI dan navigasi bekerja konsisten di seluruh aplikasi.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
StatelessWidget vs StatefulWidget: StatelessWidget tidak menyimpan state internal yang berubah; tampilannya murni dari input. StatelessWidget digunakan untuk UI statis atau yang bergantung pada data eksternal yang tidak dikelola sendiri. StatefulWidget punya objek State yang bisa berubah via setState(); StatefulWidget dipakai saat UI harus bereaksi terhadap interaksi, animasi sederhana, timer, form input, atau data yang diperbarui di dalam widget.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext adalah “alamat” sebuah widget di dalam tree; dipakai untuk lookup dependensi turun-temurun (mis. Theme.of(context), Navigator.of(context), MediaQuery.of(context)), serta memberi tahu Flutter di mana sebuah widget dibangun. Di metode build, context ini yang digunakan untuk mengakses resource/ancestor yang relevan.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
"hot reload" adalah fitur stateful yang berfungsi menyuntikkan file kode sumber yang telah diperbarui ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Mekanisme ini memungkinkan framework untuk segera membangun ulang widget tree tanpa membuang state aplikasi saat ini. Fitur ini mempercepat iterasi desain dan perbaikan bug visual secara signifikan.

Perbedaan utamanya terletak pada pengelolaan state. "Hot restart", sebaliknya, adalah proses stateless yang menghancurkan state aplikasi yang ada dan memulai ulang aplikasi dari awal.