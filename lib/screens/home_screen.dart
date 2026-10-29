import 'package:flutter/material.dart';
import '../models/note.dart';
import '../theme/neobrutalism.dart';
import 'add_note_screen.dart';
import 'detail_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<Note> _notes = [
    Note(
      id: '1',
      title: 'Ide Aplikasi',
      content: 'Membangun aplikasi catatan harian berbasis offline-first dengan Flutter dan sinkronisasi cloud.',
      category: 'Kerja',
      priority: 'Penting',
      color: NeoColors.noteColors[2],
      date: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Note(
      id: '2',
      title: 'Catatan Kuliah',
      content: 'Pertemuan mata kuliah Pemrograman Perangkat Bergerak membahas StatelessWidget, StatefulWidget, dan Navigator.',
      category: 'Kerja',
      priority: 'Sedang',
      color: NeoColors.noteColors[1],
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Note(
      id: '3',
      title: 'Hal yang Perlu Dibeli',
      content: 'Kopi biji robusta, susu segar, snack biskuit, dan kabel Type-C.',
      category: 'Pribadi',
      priority: 'Rendah',
      color: NeoColors.noteColors[0],
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Note(
      id: '4',
      title: 'Jurnal Harian',
      content: 'Hari ini berhasil memahami cara kerja state management sederhana dan arsitektur widget tree di Flutter.',
      category: 'Pribadi',
      priority: 'Sedang',
      color: NeoColors.noteColors[3],
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  List<Note> get _filteredNotes {
    return _notes.where((note) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          note.category == _selectedCategory ||
          (_selectedCategory == 'Penting' && note.priority == 'Penting');
      final matchesSearch = note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _addNote(Note newNote) {
    setState(() {
      _notes.insert(0, newNote);
    });
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', 'Penting', 'Pribadi', 'Kerja'];

    return Scaffold(
      backgroundColor: NeoColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HALO, Afif',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: NeoColors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Apa catatanmu hari ini?',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: NeoColors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: NeoBox.decoration(
                      color: NeoColors.primary,
                      radius: 12,
                      borderWidth: 2.2,
                      shadowOffset: const Offset(3, 3),
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: NeoColors.black, size: 28),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Container(
                decoration: NeoBox.decoration(
                  color: Colors.white,
                  radius: 12,
                  borderWidth: 2.2,
                  shadowOffset: const Offset(3, 3),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    hintText: 'Cari catatan...',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(Icons.search, color: NeoColors.black, size: 24),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? NeoColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: NeoColors.black, width: 2.0),
                            boxShadow: [
                              BoxShadow(
                                color: NeoColors.black,
                                offset: isSelected ? const Offset(2, 2) : const Offset(3, 3),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: NeoColors.black,
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 18),

              Expanded(
                child: _filteredNotes.isEmpty
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: NeoBox.decoration(
                            color: Colors.white,
                            radius: 12,
                            borderWidth: 2.0,
                            shadowOffset: const Offset(4, 4),
                          ),
                          child: const Text(
                            'Belum ada catatan.',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: NeoColors.black,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredNotes.length,
                        itemBuilder: (context, index) {
                          final note = _filteredNotes[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: NeoBox.decoration(
                              color: note.color,
                              radius: 12,
                              borderWidth: 2.5,
                              shadowOffset: const Offset(4, 4),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailNoteScreen(
                                        note: note,
                                        onDelete: () => _deleteNote(note.id),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              note.title,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                                color: NeoColors.black,
                                                letterSpacing: -0.3,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          NeoBadge(
                                            text: note.priority.toUpperCase(),
                                            color: note.priority == 'Penting'
                                                ? NeoColors.red
                                                : Colors.white,
                                            textColor: NeoColors.black,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        note.content,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: NeoColors.black,
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(
                                                color: NeoColors.black,
                                                width: 1.2,
                                              ),
                                            ),
                                            child: Text(
                                              note.category,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800,
                                                color: NeoColors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${note.date.day}/${note.date.month}/${note.date.year}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: NeoColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          final result = await Navigator.push<Note>(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
          if (result != null) {
            _addNote(result);
          }
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: NeoBox.decoration(
            color: NeoColors.primary,
            radius: 14,
            borderWidth: 2.8,
            shadowOffset: const Offset(4, 4),
          ),
          child: const Center(
            child: Icon(Icons.add, color: NeoColors.black, size: 32),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: NeoColors.black, width: 2.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: NeoColors.black,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          onTap: (idx) => setState(() => _currentNavIndex = idx),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home, color: NeoColors.black),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              activeIcon: Icon(Icons.archive, color: NeoColors.black),
              label: 'Arsip',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, color: NeoColors.black),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
