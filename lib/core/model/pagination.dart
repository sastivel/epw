import '../../utils/common_imports.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  int? total;

  int? pageCount;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? from;
  int? to;
  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'last_page')
  int? lastPage;

  Pagination(
      {this.total,
      this.pageCount,
      this.perPage,
      this.from,
      this.to,
      this.currentPage,
      this.lastPage});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
