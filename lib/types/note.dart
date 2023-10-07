import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Note {
  int? id;
  String title;
  String tag;
  String content;
  DateTime? date;

  Note(
      {this.id,
      required this.title,
      required this.tag,
      required this.content,
      this.date}) {
    date ??= DateTime.now();
    if (tag.isEmpty) tag = 'Untitled';
  }

  static Future<List<Note>> readData() async {
    Directory docs = await getApplicationDocumentsDirectory();
    File data = File('${docs.path}/notes.data');
    if (!await data.exists()) {
      await data.writeAsString(jsonEncode([]));
    }

    List rawNotes = jsonDecode(await data.readAsString());
    List<Note> notes = [];

    for (final (index, rawNote) in rawNotes.indexed) {
      DateTime timestamp = rawNote['date'] != null
          ? DateTime.parse(rawNote['date'])
          : DateTime.now();
      notes.add(
        Note(
            id: index,
            title: rawNote['title'],
            tag: rawNote['tag'],
            content: rawNote['content'],
            date: timestamp),
      );
    }

    return notes;
  }

  static Future<List<String>> getTags() async {
    List<String> tags = [];

    List<Note> notes = await readData();

    for (var note in notes) {
      if (!tags.contains(note.tag)) {
        tags.add(note.tag);
      }
    }

    return tags;
  }

  getTimestamp() {
    return date != null
        ? '${date!.day} / ${date!.month} / ${date!.year.toString().substring(2)}'
        : '';
  }

  toJSON() => {
        'title': title,
        'tag': tag,
        'content': content,
        'date':
            '${date!.year}-${date!.month}-${'${date!.day < 10 ? '0' : ''}${date!.day}'} 00:00:00'
      };

  saveData(List<Note> inputData) async {
    Directory docs = await getApplicationDocumentsDirectory();
    File data = File('${docs.path}/notes.data');

    await data.writeAsString(
        jsonEncode(inputData.map((note) => note.toJSON()).toList()));
  }

  static Future<List<Note>> getNotes({tag = false}) async {
    List<Note> notes = await readData();

    if (tag != false) notes.removeWhere((element) => element.tag != tag);

    return notes;
  }

  save() async {
    List<Note> notes = await readData();
    if (id == null) {
      notes.add(this);
    } else {
      int noteIndex = notes.indexWhere((element) => element.id == id);
      notes[noteIndex] = this;
    }

    saveData(notes);
  }

  delete() async {
    List<Note> notes = await readData();

    notes.removeWhere((element) => element.id == id);

    saveData(notes);
  }
}
