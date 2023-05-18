library cache;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_car/models/entities/car_entity.dart';


class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }


  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
