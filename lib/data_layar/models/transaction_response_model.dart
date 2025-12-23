import 'package:banking_app/data_layar/models/transaction_model.dart';

class TransactionResponseModel {
  final int status;
  final TransactionModel data;
  final String? message;

  TransactionResponseModel({
    required this.status,
    required this.data,
    this.message,
  });

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionResponseModel(
      status: json['status'],
      message: json['message'],
      data: TransactionModel.fromJson(json['data']),
    );
  }
}
