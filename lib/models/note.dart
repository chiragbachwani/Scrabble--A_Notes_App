class Note {
  String? nid;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;

  Note({this.nid, this.userid, this.content, this.dateadded, this.title});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      nid: map['nid'],
      userid: map['userid'],
      title: map['title'],
      dateadded: DateTime.tryParse(map['dateadded']),
      content: map['content'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nid':nid,
      'userid':userid,
      'title':title,
      'content':content,
      'dateadded': dateadded!.toIso8601String()
    };
  }
}
