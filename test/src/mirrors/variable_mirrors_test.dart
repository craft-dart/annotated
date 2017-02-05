// Copyright (c) 2017, the Craft Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:annotated/src/mirrors/variable_mirrors.dart';

import '../../lib/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Main entry-point
void main() {
  test('findConstInstancesOf', () {
    final clazz = reflect(new A('test')).type;
    final instances = findConstInstancesOf(clazz).toList();

    // Expecting 2 instances within the class
    expect(instances, hasLength(2));

    // Mirror should be const and of the requested type
    for (var instance in instances) {
      expect(instance.isConst, isTrue);
      expect(instance.type, clazz);
    }
  });

  test('getInstance', () {
    final clazz = reflect(new A('test')).type;
    final instances = findConstInstancesOf(clazz).toList();

    // Expecting 2 instances within the class
    expect(instances, hasLength(2));

    // Mirror should be const and of the requested type
    for (var instance in instances) {
      expect(instance.isConst, isTrue);
      expect(instance.type, clazz);
    }

    // Make sure the instantiated values are the same
    //
    // The value of simpleName is used which only returns the last part of the
    // qualifiedName. So checking #foo instead of #A.foo.
    final constValues = <Symbol, A>{
      #foo: A.foo,
      #bar: bar,
    };

    for (var instance in instances) {
      final expected = constValues[instance.simpleName];

      expect(expected, isNotNull);
      expect(getInstance<A>(instance), expected);
    }
  });
}
