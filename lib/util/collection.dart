import 'dart:math';

final Random _random = Random();

extension ListExt<E> on List<E> {
  E random() {
    if (isEmpty) {
      throw Exception('no element');
    }
    return this[_random.nextInt(length)];
  }

  E? whereOrNull(bool Function(E) test) {
    try {
      return firstWhere(test);
    } catch (_) {
      return null;
    }
  }

  bool contentEquals(List<E> other) {
    if (this == other) {
      return true;
    }
    if (other.length != length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (other[i] != this[i]) {
        return false;
      }
    }
    return true;
  }

  int sumIntOf(IntSelector<E> selector) {
    int sum = 0;
    forEach((element) {
      sum += selector.call(element);
    });
    return sum;
  }

  double sumDoubleOf(DoubleSelector<E> selector) {
    double sum = 0;
    forEach((element) {
      sum += selector.call(element);
    });
    return sum;
  }

  int maxOf(Selector<E> selector) {
    if (isEmpty) {
      throw Exception('no element');
    }
    var max = selector.call(this[0]);
    forEach((element) {
      final n = selector.call(element);
      if (n > max) {
        max = n;
      }
    });
    return max;
  }
}

typedef IntSelector<E> = int Function(E t);
typedef DoubleSelector<E> = double Function(E t);

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
