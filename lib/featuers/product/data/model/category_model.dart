class CategoryModel {
  String slug;
  String name;
  String url;

  CategoryModel({required this.slug, required this.name, required this.url});

  CategoryModel.fromJson(Map<String, dynamic> json)
    : slug = (json['slug'] as String?) ?? '',
      name = (json['name'] as String?) ?? '',
      url = (json['url'] as String?) ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
