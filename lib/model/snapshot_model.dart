class Data {
  Snapshot? apple;
  Snapshot? banana;
  Snapshot? melon;
  Snapshot? peach;

  Data({this.apple, this.banana, this.melon, this.peach});

  Data.fromJson(Map<String, dynamic> json) {
    apple = json['apple'] != null ? Snapshot.fromJson(json['apple']) : null;
    banana = json['banana'] != null ? Snapshot.fromJson(json['banana']) : null;
    melon = json['melon'] != null ? Snapshot.fromJson(json['melon']) : null;
    peach = json['peach'] != null ? Snapshot.fromJson(json['peach']) : null;
  }
}

class Snapshot {
  int? age;
  String? description;
  List<String>? images;
  int? likeCount;
  String? location;
  String? name;
  List<String>? tags;

  Snapshot(
      {this.age,
      this.description,
      this.images,
      this.likeCount,
      this.location,
      this.name,
      this.tags});

  Snapshot.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    description = json['description'];
    images = json['images'].cast<String>();
    images ??= [];
    likeCount = json['likeCount'];
    location = json['location'];
    name = json['name'];
    tags = json['tags'].cast<String>();
  }
}
