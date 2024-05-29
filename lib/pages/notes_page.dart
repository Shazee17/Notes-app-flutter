import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_flutter/components/drawer.dart';
import 'package:notes_app_flutter/components/note_tile.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/models/note_database.dart';
import 'package:notes_app_flutter/pages/note_details_page.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<NoteDatabase>(context, listen: false).getNotes();
  }

  // Create a new note
  void createNote() {
    _titleController.clear();
    _contentController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Content'),
              controller: _contentController,
              minLines: 5, // Set minLines to increase height
              maxLines: null, // Set maxLines to limit the height
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:Text('Cancel',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
            ),),
          ),
          TextButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty &&
                  _contentController.text.isNotEmpty) {
                context.read<NoteDatabase>().createNote(
                      title: _titleController.text,
                      content: _contentController.text,
                    );
                Navigator.pop(context);
              }
            },
            child: Text('Create',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
            ),),
          ),
        ],
      ),
    );
  }

  // Update an existing note
  void updateNoteDialog(Note note) {
    _titleController.text = note.title;
    _contentController.text = note.content;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Content'),
              controller: _contentController,
              minLines: 5, // Set minLines to increase height
              maxLines: null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty &&
                  _contentController.text.isNotEmpty) {
                context.read<NoteDatabase>().updateNote(
                      id: note.id!,
                      title: _titleController.text,
                      content: _contentController.text,
                    );
                Navigator.pop(context);
              }
            },
            child: Text(
              'Update',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
          )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Note database
    final noteDatabase = context.watch<NoteDatabase>();

    // Current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // Notes List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(note: note),
                      ),
                    ),

                    child: NoteTile(
                    title: note.title,
                    content: note.content,
                    onEdit: () => updateNoteDialog(note),
                    onDelete: () => noteDatabase.deleteNote(
                      id: note.id!,
                    ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}