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

Tugas 8

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Navigator.push() menambahkan route baru ke atas stack sehingga halaman sebelumnya tetap ada dan pengguna masih bisa kembali dengan tombol Back. Ini cocok untuk aksi seperti tombol Create Product yang membuka ProductFormPage karena setelah selesai mengisi form pengguna akan kembali ke halaman awal. Navigator.pushReplacement() menggantikan route teratas dengan route baru sehingga halaman lama tidak bisa kembali kecuali dibuat ulang. Metode ini dipakai di drawer (LeftDrawer) untuk berpindah antar halaman utama agar stack tidak terus menumpuk ketika pengguna membuka menu samping secara terus menerus.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Setiap halaman (menu utama dan form) dibangun di atas Scaffold sehingga struktur dasar seperti body, AppBar, dan Drawer konsisten. AppBar menampilkan judul “Football Shop” atau “Tambah Produk” dengan warna tema yang sama sehingga identitas visual terasa seragam. Drawer disematkan lewat properti drawer di Scaffold sehingga menu navigasi samping otomatis tersedia di seluruh halaman tanpa menggandakan kode navigasi.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Padding menjaga jarak antar elemen form. SingleChildScrollView membungkus Column berisi form agar layar tetap bisa digulir saat konten lebih tinggi daripada viewport, pengguna tidak kehilangan akses ke tombol Save. Pada drawer, ListView membuat daftar menu otomatis scrollable jika opsi bertambah. Kombinasi widget layout ini membuat tampilan adaptif di berbagai ukuran layar.

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Pertama-tama, kita menetapkan warna yang kita inginkan dalam aplikasi football-shop, lalu tetapkan palet brand sebagai ColorScheme di MaterialApp.theme. Setelah itu, penggunaan warna pada theme-level seperti AppBarTheme, EvelatedButtonTheme dan lain lain, selalu ambil warna dari Theme.of(context).colorScheme. Dengan begitu, jika dilakukan perubahan warna MaterialApp.Theme, semua warna pada keseluruhan aplikasi juga bakal ikut berubah.

Tugas 9

1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Model Dart mengikat struktur dan tipe data secara eksplisit, sehingga konversi JSON ke objek terkontrol, mendapat pemeriksaan null-safety, dan IDE dapat memberi autocompletion. Kalau langsung pakai Map<String, dynamic>, ada kemungkinan kita salah ketik keynya dan hal tersebut dapat menyebabkan runtime error. Selain itu, tanpa model, struktur data jadi tersebar di seluruh kode, sulit di-refactor kalau backend berubah, dan lebih susah dibaca/dirawat dalam jangka panjang.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest?
Http menyediakan HTTP client umum tanpa state sesi bawaan, cocok untuk pemanggilan stateless. CookieRequest adalah wrapper yang menyimpan cookie dan header autentikasi Django, mempermudah login/register/logout dan request yang butuh sesi. Di tugas ini http tidak dipakai langsung karena CookieRequest sudah menangani sesi dan parsing JSON.

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter!
CookieRequest dibagikan lewat Provider agar satu instance menempel di seluruh widget tree. Dengan begitu, cookie/login state konsisten di setiap halaman tanpa harus meneruskan objek lewat konstruktor manual, serta perubahan state login akan secara otomatis rebuild jika diperlukan.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Agar Flutter bisa berkomunikasi dengan Django, kita perlu beberapa konfigurasi jaringan: di sisi Django, 10.0.2.2 harus ditambahkan ke ALLOWED_HOSTS karena di emulator Android alamat itu adalah jembatan ke localhost, sehingga request dari aplikasi tidak dianggap ilegal dan diblokir.
Lalu CORS harus diaktifkan dan pengaturan SameSite/cookie disesuaikan supaya origin Flutter diizinkan mengakses resource Django dan cookie sesi (hasil login) bisa dikirim bolak-balik dengan benar. Di sisi Android, kita wajib menambahkan permission INTERNET di AndroidManifest.xml agar aplikasi bisa membuka koneksi HTTP/HTTPS. Jika konfigurasi ini tidak dilakukan dengan benar, request bisa gagal dengan error seperti 403/blocked host, error CORS di sisi klien, cookie login tidak pernah tersimpan sehingga selalu dianggap belum autentikasi.

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter!
Pengguna mengisi form Flutter -> Flutter memvalidasi input lalu mengirim JSON via CookieRequest.postJson ke endpoint Django -> Django memproses, menyimpan ke database, dan merespons JSON status -> Flutter membaca respons, menampilkan SnackBar/alert, dan melakukan navigasi atau refresh list → list FutureBuilder memanggil endpoint JSON Django, memetakan hasil ke model Product, lalu membangun UI berdasarkan objek tersebut.

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter!
Pada login/register, Flutter mengumpulkan username/password -> dikirim ke endpoint /auth/login/ atau /auth/register/ via CookieRequest (POST dengan cookie) -> Django memverifikasi (authenticate/create_user), mengembalikan status+username, dan menyetel cookie sesi -> CookieRequest menyimpan cookie sehingga request selanjutnya dianggap sudah login. Logout memanggil /auth/logout/, Django menghapus sesi, CookieRequest membersihkan cookie, Flutter menavigasi ke LoginPage. Setelah login sukses, halaman menu dan drawer memakai instance CookieRequest yang sama untuk mem-fetch data.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)!
Pertama-tama, saya melakukan integrasi autentikasi antar Django dan Flutter terlebih dahulu dengan menambahkan folder baru authentication pada Django saya. Lalu menambahkan pbp_django_auth, http dan izin Internet. Lalu saya melakukan fetch data menggunakan endpoint JSON dari Django untuk ditampilkan di Flutter. Setelah itu, saya mengimplementasikan fungsi login/logout/register/logout. Untuk bagian filter produk, saya menambahkan user_id sebagai JsonResponse yang nantinya akan digunakan untuk memfilter produk.