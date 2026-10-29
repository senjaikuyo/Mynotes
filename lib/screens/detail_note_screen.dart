import 'package:flutter/material.dart';
import '../models/note.dart';
import '../theme/neobrutalism.dart';

class DetailNoteScreen extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const DetailNoteScreen({
    super.key,
    required this.note,
    required this.onDelete,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: NeoColors.black, width: 2.8),
        ),
        title: const Text(
          'HAPUS CATATAN?',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: NeoColors.black,
            letterSpacing: -0.5,
          ),
        ),
        content: const Text(
          'Apakah kamu yakin ingin menghapus catatan ini secara permanen?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: NeoColors.black,
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: NeoButton(
                  onPressed: () => Navigator.pop(ctx),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('BATAL', style: TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeoButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    onDelete();
                    Navigator.pop(context);
                  },
                  color: NeoColors.red,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('HAPUS', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.background,
      appBar: AppBar(
        title: const Text('DETAIL CATATAN'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: NeoBox.decoration(
              color: Colors.white,
              radius: 8,
              borderWidth: 2.0,
              shadowOffset: const Offset(2, 2),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20, color: NeoColors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur edit catatan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: NeoBox.decoration(
              color: NeoColors.red,
              radius: 8,
              borderWidth: 2.0,
              shadowOffset: const Offset(2, 2),
            ),
            child: IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: NeoColors.black),
              onPressed: () => _showDeleteDialog(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            decoration: NeoBox.decoration(
              color: note.color,
              radius: 16,
              borderWidth: 2.8,
              shadowOffset: const Offset(5, 5),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeoBadge(
                      text: note.category.toUpperCase(),
                      color: Colors.white,
                    ),
                    NeoBadge(
                      text: note.priority.toUpperCase(),
                      color: note.priority == 'Penting' ? NeoColors.red : Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: NeoColors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${note.date.day} Oktober 2026 • ${note.date.hour.toString().padLeft(2, '0')}:${note.date.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: NeoColors.black, thickness: 2.0),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      note.content,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                        color: NeoColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
