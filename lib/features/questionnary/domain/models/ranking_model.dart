import 'package:two_gis_hackaton/features/questionnary/domain/models/polygon_model.dart';

class RankingModel {
  const RankingModel({
    required this.items,
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      items: (json['items'] as List)
          .map((e) => PolygonModel.fromJson(e))
          .toList(),
      totalItems: json['total_items'] as int,
      totalPages: json['total_pages'] as int,
      currentPage: json['current_page'] as int,
      pageSize: json['page_size'] as int,
    );
  }


  final List<PolygonModel> items;
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int pageSize;
}
