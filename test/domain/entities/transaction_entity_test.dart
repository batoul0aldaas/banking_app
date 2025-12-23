import 'package:flutter_test/flutter_test.dart';
import 'package:banking_app/domain/entities/transaction.dart';

void main() {
  group('TransactionEntity', () {
    test('يجب إنشاء TransactionEntity بالقيم الصحيحة', () {
      final transaction = TransactionEntity(
        referenceNumber: 'TXN-001',
        type: 'deposit',
        status: 'completed',
        amount: 100,
        currency: 'USD',
        accountReference: 'ACC-001',
        relatedAccountReference: null,
        metadata: const [],
        processedAt: DateTime(2025, 1, 1),
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      );

      expect(transaction.referenceNumber, 'TXN-001');
      expect(transaction.type, 'deposit');
      expect(transaction.amount, 100);
      expect(transaction.accountReference, 'ACC-001');
      expect(transaction.relatedAccountReference, null);
    });

    test('يجب أن تكون الكيانات المتطابقة متساوية (Equatable)', () {
      final t1 = TransactionEntity(
        referenceNumber: 'TXN-001',
        type: 'deposit',
        status: 'completed',
        amount: 100,
        currency: 'USD',
        accountReference: 'ACC-001',
        relatedAccountReference: null,
        metadata: const [],
        processedAt: DateTime(2025, 1, 1),
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      );

      final t2 = TransactionEntity(
        referenceNumber: 'TXN-001',
        type: 'deposit',
        status: 'completed',
        amount: 100,
        currency: 'USD',
        accountReference: 'ACC-001',
        relatedAccountReference: null,
        metadata: const [],
        processedAt: DateTime(2025, 1, 1),
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      );

      expect(t1, equals(t2));
    });
  });
}
