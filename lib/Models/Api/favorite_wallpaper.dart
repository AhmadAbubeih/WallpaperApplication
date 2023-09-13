class FavoriteWallpaper {
  int? id;
  String? photoUrl;

  FavoriteWallpaper({this.id, this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
    };
  }

  static FavoriteWallpaper fromMap(Map<String, dynamic> map) {
    return FavoriteWallpaper(
      id: map['id'],
      photoUrl: map['photoUrl'],
    );
  }
}
