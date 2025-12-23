class AccountCreateRequest {
  final String name;
  final String type;
  final String? parentReference;

  const AccountCreateRequest({
    required this.name,
    required this.type,
    this.parentReference,
  });
}

/// Builder Pattern لتجميع بيانات إنشاء الحساب بشكل آمن ومتّسق.
class AccountCreateRequestBuilder {
  String? _name;
  String? _type;
  String? _parentReference;

  AccountCreateRequestBuilder withName(String name) {
    _name = name.trim();
    return this;
  }

  AccountCreateRequestBuilder withType(String type) {
    _type = type.trim();
    return this;
  }

  AccountCreateRequestBuilder withParentReference(String? parentReference) {
    final trimmed = parentReference?.trim();
    _parentReference = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    return this;
  }

  /// التحقق من صحة البيانات قبل البناء.
  void _validate() {
    if (_name == null || _name!.isEmpty) {
      throw ArgumentError('Account name is required');
    }
    if (_type == null || _type!.isEmpty) {
      throw ArgumentError('Account type is required');
    }
  }

  AccountCreateRequest build() {
    _validate();
    return AccountCreateRequest(
      name: _name!,
      type: _type!,
      parentReference: _parentReference,
    );
  }
}