import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/components/note_model.dart';

class NoteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addNote(Note note, String userId) async {
    await _db.collection('users').doc(userId).collection('notes').add({
      'title': note.title,
      'content': note.content,
      'date': note.date,
    });
  }

  // Implement other CRUD operations as previously shown...
}
