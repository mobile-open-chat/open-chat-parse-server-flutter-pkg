// ignore_for_file: parameter_assignments, avoid_dynamic_calls, unnecessary_parenthesis

import 'package:collection/collection.dart';

/// Returns a `hashCode` for [props].
int jenkinsMapPropsToHashCode(Iterable? props) =>
    _finish(props == null ? 0 : props.fold(0, _combine));

/// Jenkins Hash Functions
/// https://en.wikipedia.org/wiki/Jenkins_hash_function
int _combine(int hash, dynamic object) {
  if (object is Map) {
    object.keys
        .sorted((dynamic a, dynamic b) => a.hashCode - b.hashCode)
        .forEach((dynamic key) {
      hash = hash ^ _combine(hash, <dynamic>[key, object[key]]);
    });
    return hash;
  }
  if (object is Set) {
    object = object.sorted(((dynamic a, dynamic b) => a.hashCode - b.hashCode));
  }
  if (object is Iterable) {
    for (final value in object) {
      hash = hash ^ _combine(hash, value);
    }
    return hash ^ object.length;
  }

  hash = 0x1fffffff & (hash + object.hashCode);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
