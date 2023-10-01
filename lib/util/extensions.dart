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

extension ToString on int {
  String toFix0String(int length) {
    if (this < 0) {
      return toString();
    }
    int n = this;
    int len;
    if (this == 0) {
      len = 1;
    } else {
      len = 0;
      while (n != 0) {
        len++;
        n ~/= 10;
      }
    }
    var str = '';
    for (int i = 0; i < length - len; i++) {
      str += '0';
    }
    return str + toString();
  }
}

typedef Selector<E> = int Function(E t);

extension SetExt<E> on Set<E> {
  bool contentEquals(Set<E> other) {
    if (this == other) {
      return true;
    }
    if (other.length != length) {
      return false;
    }
    for (final e in this) {
      if (!other.contains(e)) {
        return false;
      }
    }
    for (final e in other) {
      if (!contains(e)) {
        return false;
      }
    }
    return true;
  }

  int sumOf(Selector<E> selector) {
    var sum = 0;
    forEach((element) {
      sum += selector.call(element);
    });
    return sum;
  }

  int maxOf(Selector<E> selector) {
    if (isEmpty) {
      throw Exception('no element');
    }
    var i = iterator;
    i.moveNext();
    int max = selector.call(i.current);
    while (i.moveNext()) {
      final n = selector.call(i.current);
      if (n > max) {
        max = n;
      }
    }
    return max;
  }
}

