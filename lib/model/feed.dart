class Feed {
  String? name;
  String? profile;
  String? contains;
  String? image;
  String? id;
  bool isDoubleTapped;

  Feed({
    this.name,
    this.id,
    this.profile,
    this.contains,
    this.image,
    this.isDoubleTapped = false,
  });

  Feed.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        profile = json['profile'],
        contains = json['contains'],
        image = json['image'],
        id = json['id'],
        isDoubleTapped = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile'] = this.profile;
    data['contains'] = this.contains;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}
