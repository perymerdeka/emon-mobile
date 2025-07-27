// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSummary _$ReportSummaryFromJson(Map<String, dynamic> json) =>
    ReportSummary(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      netIncome: (json['netIncome'] as num).toDouble(),
      totalTransactions: (json['totalTransactions'] as num).toInt(),
      categoryBreakdown: (json['category_breakdown'] as List<dynamic>)
          .map((e) => CategoryBreakdown.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$ReportSummaryToJson(ReportSummary instance) =>
    <String, dynamic>{
      'totalIncome': instance.totalIncome,
      'totalExpense': instance.totalExpense,
      'netIncome': instance.netIncome,
      'totalTransactions': instance.totalTransactions,
      'category_breakdown': instance.categoryBreakdown,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };

CategoryBreakdown _$CategoryBreakdownFromJson(Map<String, dynamic> json) =>
    CategoryBreakdown(
      categoryId: (json['category_id'] as num).toInt(),
      categoryName: json['category_name'] as String,
      categoryType: $enumDecode(_$CategoryTypeEnumMap, json['category_type']),
      amount: (json['amount'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$CategoryBreakdownToJson(CategoryBreakdown instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'category_type': _$CategoryTypeEnumMap[instance.categoryType]!,
      'amount': instance.amount,
      'count': instance.count,
      'percentage': instance.percentage,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.income: 'income',
  CategoryType.expense: 'expense',
};

MonthlyReport _$MonthlyReportFromJson(Map<String, dynamic> json) =>
    MonthlyReport(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      summary: ReportSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MonthlyReportToJson(MonthlyReport instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'summary': instance.summary,
    };

YearlyReport _$YearlyReportFromJson(Map<String, dynamic> json) => YearlyReport(
  year: (json['year'] as num).toInt(),
  summary: ReportSummary.fromJson(json['summary'] as Map<String, dynamic>),
  monthlyBreakdown: (json['monthly_breakdown'] as List<dynamic>)
      .map((e) => MonthlyBreakdown.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$YearlyReportToJson(YearlyReport instance) =>
    <String, dynamic>{
      'year': instance.year,
      'summary': instance.summary,
      'monthly_breakdown': instance.monthlyBreakdown,
    };

MonthlyBreakdown _$MonthlyBreakdownFromJson(Map<String, dynamic> json) =>
    MonthlyBreakdown(
      month: (json['month'] as num).toInt(),
      income: (json['income'] as num).toDouble(),
      expense: (json['expense'] as num).toDouble(),
      net: (json['net'] as num).toDouble(),
    );

Map<String, dynamic> _$MonthlyBreakdownToJson(MonthlyBreakdown instance) =>
    <String, dynamic>{
      'month': instance.month,
      'income': instance.income,
      'expense': instance.expense,
      'net': instance.net,
    };

CustomReportRequest _$CustomReportRequestFromJson(Map<String, dynamic> json) =>
    CustomReportRequest(
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomReportRequestToJson(
  CustomReportRequest instance,
) => <String, dynamic>{
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'category_id': instance.categoryId,
};
