import 'package:flutter/material.dart';
import 'package:notesapp/types/note.dart';

class NoteScreen extends StatefulWidget {
  static const route = '/note';
  final Note? note;
  const NoteScreen({super.key, this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool canAnimate = false;
  Note? currentNote;

  saveChanges() async {
    await currentNote!.save();
    Navigator.pop(context);
  }

  deleteNote() async {
    await currentNote!.delete();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note == null)
      currentNote = Note(title: 'Untitled', content: '', tag: '');
    else
      currentNote = widget.note;
    setState(() {});
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        canAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        Positioned(
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(children: [
              AnimatedOpacity(
                curve: Curves.ease,
                opacity: canAnimate ? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Note',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        widget.note != null
                            ? Row(children: [
                                InkWell(
                                  onTap: deleteNote,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                )
                              ])
                            : Container(),
                        InkWell(
                          onTap: saveChanges,
                          child: Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                        )
                      ]),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                ),
              ),
              AnimatedSize(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 400),
                  child: Container(
                    color: Colors.black,
                    height: 1,
                    width: canAnimate ? null : 0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  )),
              Container(
                child: Row(
                  children: [
                    Text(
                      currentNote?.getTimestamp() ?? '',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      children: [
                        Text(
                          "#",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Container(
                          width: 100,
                          child: TextFormField(
                            onChanged: (value) => setState(() {
                              currentNote?.tag = value;
                            }),
                            initialValue: currentNote?.tag ?? '',
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintText: 'Tag',
                                hintStyle: TextStyle(color: Colors.black54)),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Container(
                child: TextFormField(
                  onChanged: (value) => setState(() {
                    currentNote?.title = value;
                  }),
                  initialValue: currentNote?.title ?? '',
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.black54)),
                  style: TextStyle(fontSize: 48, color: Colors.black),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Container(
                child: TextFormField(
                  onChanged: (value) => setState(() {
                    currentNote?.content = value;
                  }),
                  cursorColor: Colors.black,
                  initialValue: currentNote?.content ?? '',
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Note description',
                      hintStyle: TextStyle(color: Colors.black54)),
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              )
            ]),
            scrollDirection: Axis.vertical,
          ),
          bottom: 0,
          left: 0,
          top: 0,
          right: 0,
        )
      ]),
    );
  }
}
