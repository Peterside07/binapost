class PostModel {
  final String id;
  final String userId;
  final String username;
  final String? description;
  final String link; // either image or video link
  final String thumbnail; // for videos (preview image)
  final bool noMedia; // false => media exists
  final bool video; // "true"/"false" in your payload; parse accordingly
  final int timestamp;

  PostModel({
    required this.id,
    required this.userId,
    required this.username,
    this.description,
    required this.link,
    required this.thumbnail,
    required this.noMedia,
    required this.video,
    required this.timestamp,
  });

  factory PostModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PostModel(
      id: documentId,
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      description: map['description'],
      link: map['link'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      noMedia: map['no_media'] ?? false,
      video: map['video'] == true || map['video'] == 'true',

      timestamp: map['timestamp'] ?? 0,
    );
  }
}
