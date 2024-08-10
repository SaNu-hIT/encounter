class HomeRespo {
  String? status;
  List<Data>? data;
  BibleVerse? bibleVerse;
  LoginUser? loginUser;

  HomeRespo(
      {this.status,  this.data, this.bibleVerse, this.loginUser});

  HomeRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
 
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    bibleVerse = json['BibleVerse'] != null
        ? new BibleVerse.fromJson(json['BibleVerse'])
        : null;
    loginUser = json['LoginUser'] != null
        ? new LoginUser.fromJson(json['LoginUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.bibleVerse != null) {
      data['BibleVerse'] = this.bibleVerse!.toJson();
    }
    if (this.loginUser != null) {
      data['LoginUser'] = this.loginUser!.toJson();
    }
    return data;
  }
}

class Data {
  String? category;
  List<BibileList>? list;
  Data({this.category, this.list});
  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['list'] != null) {
      list = <BibileList>[];
      json['list'].forEach((v) {
        list!.add(new BibileList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BibileList {
  int? id;
  String? data1;
  String? image;
  String? data2;

  BibileList({this.id, this.data1, this.image, this.data2});

  BibileList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data1 = json['data1'];
    image = json['image'];
    data2 = json['data2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data1'] = this.data1;
    data['image'] = this.image;
    data['data2'] = this.data2;
    return data;
  }
}

class BibleVerse {
  int? id;
  String? image;
  String? data2;
  int? verseId;
  String? data1;

  BibleVerse({this.id, this.image, this.data2, this.verseId, this.data1});

  BibleVerse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    data2 = json['data2'];
    verseId = json['verse_id'];
    data1 = json['data1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['data2'] = this.data2;
    data['verse_id'] = this.verseId;
    data['data1'] = this.data1;
    return data;
  }
}

class LoginUser {
  int? id;
  String? image;
  String? userName;

  LoginUser({this.id, this.image, this.userName});

  LoginUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['user_name'] = this.userName;
    return data;
  }
}
