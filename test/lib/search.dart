// Copyright (c) 2017, the Craft Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library annotated.test.lib.search;

class A {
  final String name;
  final int anInt;

  const A(this.name) : anInt = 0;

  A.notConstConstructor()
      : name = '',
        anInt = 1;

  const A.baz()
      : name = 'baz',
        anInt = 2;

  static const A foo = const A('foo');
  static final A classInstanceNotConst = new A.notConstConstructor();
}

const A bar = const A('bar');
final A libraryInstanceNotConst = new A.notConstConstructor();
