// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: json['total'] as int?,
      pageCount: json['pageCount'] as int?,
      perPage: json['per_page'] as int?,
      from: json['from'] as int?,
      to: json['to'] as int?,
      currentPage: json['current_page'] as int?,
      lastPage: json['last_page'] as int?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'pageCount': instance.pageCount,
      'per_page': instance.perPage,
      'from': instance.from,
      'to': instance.to,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };
