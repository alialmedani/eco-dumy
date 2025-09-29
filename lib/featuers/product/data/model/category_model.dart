class CategoryModel {
  final String slug;
  final String name;
  final String url;
  CategoryModel({required this.slug, required this.name, required this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    slug: json['slug']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    url: json['url']?.toString() ?? '',
  );
}
