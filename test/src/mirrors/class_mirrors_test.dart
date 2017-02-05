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

import 'package:annotated/src/mirrors/class_mirrors.dart';

import '../../lib/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Main entry-point
void main() {
  test('classConstConstructors', () {
    final clazz = reflect(new A('test')).type;

    // Get the constructors
    final constructors = classConstConstructors(clazz);

    expect(constructors, hasLength(2));

    // Mirror should be const constructor
    for (var constructor in constructors) {
      expect(constructor.isConstConstructor, isTrue);
    }

    // Check for the symbols
    final constructorSymbols = constructors.map((v) => v.constructorName);

    expect(constructorSymbols, contains(new Symbol('')));
    expect(constructorSymbols, contains(new Symbol('baz')));
  });

  test('classFields', () {
    final clazz = reflect(new A('test')).type;

    // Get the final fields
    final fields = classFinalFields(clazz).toList();

    expect(fields, hasLength(2));

    // Mirror should be final and not static
    for (var field in fields) {
      expect(field.isFinal, isTrue);
      expect(field.isStatic, isFalse);
    }

    // Check for the symbols
    final fieldSymbols = fields.map((v) => v.simpleName);

    expect(fieldSymbols, contains(new Symbol('name')));
    expect(fieldSymbols, contains(new Symbol('anInt')));
  });
}
