import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  final List<String> _categories = const [
    'Jersey',
    'Jacket',
    'Hoodie',
    'Cap',
    'Others',
  ];

  String _selectedCategory = 'Jersey';
  bool _isFeatured = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _thumbnailController.clear();
    setState(() {
      _selectedCategory = _categories.first;
      _isFeatured = false;
    });
  }

  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Produk berhasil tersimpan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama: ${_nameController.text}'),
              Text('Harga: Rp${_priceController.text}'),
              Text('Kategori: $_selectedCategory'),
              Text('Deskripsi: ${_descriptionController.text}'),
              Text('Thumbnail: ${_thumbnailController.text}'),
              Text('Featured: ${_isFeatured ? "Ya" : "Tidak"}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Nama Produk",
                    hintText: "Contoh: Jersey Home 24/25",
                  ),
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong.";
                    }
                    if (value.trim().length < 3) {
                      return "Nama produk minimal 3 karakter.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: "Harga Produk",
                    hintText: "Contoh: 250000",
                    prefixText: "Rp ",
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong.";
                    }
                    final parsed = int.tryParse(value);
                    if (parsed == null) {
                      return "Harga harus berupa angka.";
                    }
                    if (parsed <= 0) {
                      return "Harga harus lebih dari 0.";
                    }
                    if (parsed > 100000000) {
                      return "Harga terlalu besar untuk katalog.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: "Kategori",
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Deskripsi Produk",
                    alignLabelWithHint: true,
                    hintText: "Tuliskan deskripsi singkat produk.",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong.";
                    }
                    if (value.trim().length < 10) {
                      return "Deskripsi minimal 10 karakter.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _thumbnailController,
                  decoration: const InputDecoration(
                    labelText: "URL Thumbnail",
                    hintText: "https://contoh.com/gambar.jpg",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "URL thumbnail tidak boleh kosong.";
                    }
                    final uri = Uri.tryParse(value);
                    final hasValidScheme =
                        uri != null && (uri.isScheme("http") || uri.isScheme("https"));
                    if (!hasValidScheme || uri.host.isEmpty) {
                      return "Masukkan URL yang valid.";
                    }
                    return null;
                  },
                ),
              ),
              SwitchListTile(
                title: const Text("Tandai sebagai produk Featured"),
                value: _isFeatured,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt),
                  label: const Text("Save"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSummaryDialog();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
