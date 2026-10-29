import 'package:flutter/material.dart';
import '../models/note.dart';
import '../theme/neobrutalism.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  String _category = 'Kerja';
  String _priority = 'Sedang';
  Color _selectedColor = NeoColors.noteColors[0];

  final List<Color> _colorPalette = NeoColors.noteColors;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _category,
        priority: _priority,
        color: _selectedColor,
        date: DateTime.now(),
      );
      Navigator.pop(context, newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.background,
      appBar: AppBar(
        title: const Text('TAMBAH CATATAN'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: NeoBox.decoration(
                    color: Colors.white,
                    radius: 12,
                    borderWidth: 2.2,
                    shadowOffset: const Offset(3, 3),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: TextFormField(
                    controller: _titleController,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'Judul Catatan',
                      labelStyle: TextStyle(
                        color: NeoColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Judul catatan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                Container(
                  decoration: NeoBox.decoration(
                    color: Colors.white,
                    radius: 12,
                    borderWidth: 2.2,
                    shadowOffset: const Offset(3, 3),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: DropdownButtonFormField<String>(
                    initialValue: _category,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: NeoColors.black,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      labelStyle: TextStyle(
                        color: NeoColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Kerja', child: Text('Kerja')),
                      DropdownMenuItem(value: 'Pribadi', child: Text('Pribadi')),
                      DropdownMenuItem(value: 'Belanja', child: Text('Belanja')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _category = val);
                    },
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'WARNA KARTU',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: NeoColors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: _colorPalette.map((color) {
                    final isSelected = _selectedColor == color;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: NeoColors.black,
                            width: isSelected ? 3.0 : 2.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: NeoColors.black,
                              offset: isSelected ? const Offset(1, 1) : const Offset(3, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, size: 24, color: NeoColors.black)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                const Text(
                  'PRIORITAS',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: NeoColors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: ['Rendah', 'Sedang', 'Penting'].map((priority) {
                    final isSelected = _priority == priority;
                    Color badgeColor = Colors.white;
                    if (isSelected) {
                      badgeColor = priority == 'Penting'
                          ? NeoColors.red
                          : (priority == 'Sedang' ? NeoColors.primary : NeoColors.mint);
                    }

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                          onTap: () => setState(() => _priority = priority),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: NeoColors.black, width: 2.2),
                              boxShadow: [
                                BoxShadow(
                                  color: NeoColors.black,
                                  offset: isSelected ? const Offset(1, 1) : const Offset(3, 3),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                priority.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  color: NeoColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                Container(
                  decoration: NeoBox.decoration(
                    color: Colors.white,
                    radius: 12,
                    borderWidth: 2.2,
                    shadowOffset: const Offset(3, 3),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: TextFormField(
                    controller: _contentController,
                    maxLines: 7,
                    style: const TextStyle(fontWeight: FontWeight.w600, height: 1.5),
                    decoration: const InputDecoration(
                      labelText: 'Isi Catatan',
                      labelStyle: TextStyle(
                        color: NeoColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Isi catatan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 28),

                NeoButton(
                  onPressed: _saveNote,
                  color: NeoColors.primary,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_outlined, color: NeoColors.black),
                      SizedBox(width: 8),
                      Text('SIMPAN CATATAN'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
