import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportSummary {
  final double totalIncome;
  final double totalExpense;
  final double netIncome;
  final int totalTransactions;
  @JsonKey(name: 'category_breakdown')
  final List<CategoryBreakdown> categoryBreakdown;
  final DateTime? startDate;
  final DateTime? endDate;

  ReportSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.netIncome,
    required this.totalTransactions,
    required this.categoryBreakdown,
    this.startDate,
    this.endDate,
  });

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ReportSummaryToJson(this);
}

@JsonSerializable()
class CategoryBreakdown {
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'category_type')
  final CategoryType categoryType;
  final double amount;
  final int count;
  final double percentage;

  CategoryBreakdown({
    required this.categoryId,
    required this.categoryName,
    required this.categoryType,
    required this.amount,
    required this.count,
    required this.percentage,
  });

  factory CategoryBreakdown.fromJson(Map<String, dynamic> json) =>
      _$CategoryBreakdownFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryBreakdownToJson(this);
}

@JsonSerializable()
class MonthlyReport {
  final int month;
  final int year;
  final ReportSummary summary;

  MonthlyReport({
    required this.month,
    required this.year,
    required this.summary,
  });

  factory MonthlyReport.fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyReportToJson(this);
}

@JsonSerializable()
class YearlyReport {
  final int year;
  final ReportSummary summary;
  @JsonKey(name: 'monthly_breakdown')
  final List<MonthlyBreakdown> monthlyBreakdown;

  YearlyReport({
    required this.year,
    required this.summary,
    required this.monthlyBreakdown,
  });

  factory YearlyReport.fromJson(Map<String, dynamic> json) =>
      _$YearlyReportFromJson(json);
  Map<String, dynamic> toJson() => _$YearlyReportToJson(this);
}

@JsonSerializable()
class MonthlyBreakdown {
  final int month;
  final double income;
  final double expense;
  final double net;

  MonthlyBreakdown({
    required this.month,
    required this.income,
    required this.expense,
    required this.net,
  });

  factory MonthlyBreakdown.fromJson(Map<String, dynamic> json) =>
      _$MonthlyBreakdownFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyBreakdownToJson(this);
}

@JsonSerializable()
class CustomReportRequest {
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @JsonKey(name: 'category_id')
  final int? categoryId;

  CustomReportRequest({
    required this.startDate,
    required this.endDate,
    this.categoryId,
  });

  factory CustomReportRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CustomReportRequestToJson(this);
}
