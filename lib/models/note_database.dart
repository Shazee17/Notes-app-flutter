import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
    print("database initialized");
  }

  final List<Note> currentNotes = [];

  // Create a new note
  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    final note = Note()
      ..title = title
      ..content = content;

    // Save the note to the database
    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });

    // Re-read all notes from the database
    await getNotes();
    notifyListeners();
    print("Given note is saved");
  }

  // Read notes
  Future<void> getNotes() async {
    final notes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(notes);
    notifyListeners();
  }

  // Update a note
  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.title = title;
      existingNote.content = content;

      await isar.writeTxn(() async {
        await isar.notes.put(existingNote);
      });

      await getNotes();
    }
  }

  // Delete a note
  Future<void> deleteNote({
    required int id,
  }) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
    await getNotes();
  }
}
