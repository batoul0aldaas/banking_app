class AccountUpdateRequest {
  final String referenceNumber;
  final String? name;
  final String? type;
  final String? parentReference;
  final String? status;

  const AccountUpdateRequest({
    required this.referenceNumber,
    this.name,
    this.type,
    this.parentReference,
    this.status,
  });
}

class AccountUpdateRequestBuilder {
  final String referenceNumber;
  String? _name;
  String? _type;
  String? _parentReference;
  String? _status;

  AccountUpdateRequestBuilder({
    required this.referenceNumber,
  });

  AccountUpdateRequestBuilder withName(String? name) {
    if (name != null) {
      final trimmed = name.trim();
      _name = trimmed.isEmpty ? null : trimmed;
    } else {
      _name = null;
    }
    return this;
  }
  AccountUpdateRequestBuilder withType(String? type) {
    if (type != null) {
      final trimmed = type.trim();
      _type = trimmed.isEmpty ? null : trimmed;
    } else {
      _type = null;
    }
    return this;
  }

  AccountUpdateRequestBuilder withParentReference(String? parentReference) {
    if (parentReference != null) {
      final trimmed = parentReference.trim();
      _parentReference = trimmed.isEmpty ? null : trimmed;
    } else {
      _parentReference = null;
    }
    return this;
  }

  AccountUpdateRequestBuilder withStatus(String? status) {
    if (status != null) {
      final trimmed = status.trim();
      _status = trimmed.isEmpty ? null : trimmed;
    } else {
      _status = null;
    }
    return this;
  }

  AccountUpdateRequest build() {
    return AccountUpdateRequest(
      referenceNumber: referenceNumber,
      name: _name,
      type: _type,
      parentReference: _parentReference,
      status: _status,
    );
  }
}