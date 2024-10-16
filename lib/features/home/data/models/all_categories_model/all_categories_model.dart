import 'datum.dart';
import 'pagination_result.dart';

class AllCategoriesModel {
  int? results;
  int? totlaCount;
  PaginationResult? paginationResult;
  List<Category>? data;

  AllCategoriesModel({
    this.results,
    this.totlaCount,
    this.paginationResult,
    this.data,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AllCategoriesModel(
      results: json['results'] as int?,
      totlaCount: json['totlaCount'] as int?,
      paginationResult: json['paginationResult'] == null
          ? null
          : PaginationResult.fromJson(
              json['paginationResult'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results,
        'totlaCount': totlaCount,
        'paginationResult': paginationResult?.toJson(),
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
