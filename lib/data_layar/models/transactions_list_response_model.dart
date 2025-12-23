import 'package:banking_app/data_layar/models/transaction_model.dart';

class TransactionsListResponseModel {
  final int status;
  final List<TransactionModel> data;
  final String? message;

  TransactionsListResponseModel({
    required this.status,
    required this.data,
    this.message,
  });

  factory TransactionsListResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionsListResponseModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
    );
  }
}
