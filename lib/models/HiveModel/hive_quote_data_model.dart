import 'package:hive/hive.dart';

part 'hive_quote_data_model.g.dart';

@HiveType(typeId: 1)
class HiveQuoteDataModel {
  HiveQuoteDataModel({
    this.id,
    required this.category,
    required this.quote,
    required this.language,
    this.author,
    required this.isFavourite,
  });
  @HiveField(0)
  int? id;

  @HiveField(1)
  String category;

  @HiveField(2)
  String language;

  @HiveField(3)
  String quote;

  @HiveField(4)
  String? author;

  @HiveField(5, defaultValue: false)
  bool isFavourite = false;
}
