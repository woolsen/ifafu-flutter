import 'package:ifafu/http/model.dart';

extension StringExtensions on String? {
  bool get isBlank {
    return this == null || this!.trim().isEmpty;
  }
}

extension Iterables<E> on Iterable<E> {

  Iterable<T> mapNotNull<T>(T Function(E e) toElement) {
    return map(toElement).where((e) => e != null);
  }
}

extension UserExtensions on User {
  bool hasPermission(String permission) {
    return permissions.contains('admin') || permissions.contains(permission);
  }
}