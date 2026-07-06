class SampleModel {
  final String id;
  final String title;

  SampleModel({required this.id, required this.title});

  factory SampleModel.fromJson(Map<String, dynamic> json) => SampleModel(
        id: json['_id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
      );
}
