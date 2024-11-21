import 'package:athendat/features/home/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel extends Product with _$ProductModel {
  const factory ProductModel(
      {required int id,
      required String title,
      required String body,
      //when the call come from the api, set default value as 0
      @Default(0) int approved,
      @Default('') String uuid}) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  static const productMockEmpty = ProductModel(
    id: 0,
    title: '',
    body: '',
    approved: 0,
  );
}
