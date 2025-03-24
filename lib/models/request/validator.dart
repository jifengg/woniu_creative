dynamic isNotNull(Map<String, dynamic> json, String key) {
  var v = json[key];
  if (v == null) {
    throw ArgumentError('$key is required');
  }
  return v;
}

void isNotLessThan(dynamic v, dynamic min) {
  if (v is int && min is int) {
    if (v < min) {
      throw ArgumentError('$v must be greater than or equal to $min');
    }
  } else if (v is double && min is double) {
    if (v < min) {
      throw ArgumentError('$v must be greater than or equal to $min');
    }
  } else if (v is String && min is int) {
    if (v.length < min) {
      throw ArgumentError(
        'string $v length must be greater than or equal to $min',
      );
    }
  }
}

void isNotGreaterThan(dynamic v, dynamic max) {
  if (v is int && max is int) {
    if (v > max) {
      throw ArgumentError('$v must be less than or equal to $max');
    }
  } else if (v is double && max is double) {
    if (v > max) {
      throw ArgumentError('$v must be less than or equal to $max');
    }
  } else if (v is String && max is int) {
    if (v.length > max) {
      throw ArgumentError(
        'string $v length must be less than or equal to $max',
      );
    }
  }
}

int? getInt(
  Map<String, dynamic> json,
  String key, {
  bool required = true,
  int? min,
  int? max,
}) {
  if (!required && json[key] == null) {
    return null;
  }
  var v = isNotNull(json, key);
  var id = v is int ? v : int.tryParse(v);
  if (id == null) {
    throw ArgumentError('$key must be an integer');
  }
  if (min != null) isNotLessThan(id, min);
  if (max != null) isNotGreaterThan(id, max);
  return id;
}

int? getUint(
  Map<String, dynamic> json,
  String key, {
  bool required = true,
  int? min,
  int? max,
}) {
  if (min != null) {
    min = min < 1 ? 1 : min;
  }
  return getInt(json, key, required: required, min: min, max: max);
}

String? getString(
  Map<String, dynamic> json,
  String key, {
  bool required = true,
  int? min,
  int? max,
}) {
  if (!required && json[key] == null) {
    return null;
  }
  var v = isNotNull(json, key);
  if (v is String == false) {
    v = v.toString();
  }
  if (min != null) isNotLessThan(v, min);
  if (max != null) isNotGreaterThan(v, max);
  return v;
}

Map<String, dynamic>? getMap(
  Map<String, dynamic> json,
  String key, {
  bool required = true,
}) {
  if (!required && json[key] == null) {
    return null;
  }
  var v = isNotNull(json, key);
  if (v is Map<String, dynamic> == false) {
    throw ArgumentError('$key must be a map');
  }
  return v;
}
