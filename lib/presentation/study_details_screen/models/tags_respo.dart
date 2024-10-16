class TagsRespo {
  String? status;
  List<TagData>? data;

  TagsRespo({this.status, this.data});

  TagsRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      data = <TagData>[];
      json['data'].forEach((v) {
        data!.add(new TagData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TagData {
  int? id;
  String? tagName;

  TagData({this.id, this.tagName});

  TagData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_name'] = this.tagName;
    return data;
  }
}
