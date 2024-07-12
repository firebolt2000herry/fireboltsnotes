// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();

  void _addNote() {
    if (_titleController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('notes').add({
        'title': _titleController.text,
        'date': DateTime.now(),
        'userId': FirebaseAuth.instance.currentUser!.uid,
      }).then((value) {
        _titleController.clear();
      }).catchError((error) => print('Failed to add note: $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter note title',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No notes found.'));
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    DateTime noteDate = data['date'].toDate();
                    String formattedDate = DateFormat.yMMMd().format(noteDate);

                    return ListTile(
                      title: Text(data['title']),
                      subtitle: Text(formattedDate),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('notes').doc(document.id).delete().then((value) {
                            print('Note deleted successfully');
                          }).catchError((error) => print('Failed to delete note: $error'));
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
