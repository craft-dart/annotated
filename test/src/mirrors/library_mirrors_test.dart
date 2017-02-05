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

import 'package:annotated/src/mirrors/library_mirrors.dart';

import '../../lib/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Main entry-point
void main() {
  test('findClassMirror', () {
    // Get the expected class mirror
    final expected = reflect(new A('test')).type;

    expect(findClassMirror('A'), expected);
    expect(findClassMirror('A', 'annotated.test.lib.search'), expected);
  });

  test('findClassMirror error conditions', () {
    // Search entire program for a class name that doesn't exist
    expect(() => findClassMirror('DoesNotExist'), throwsArgumentError);

    // Search library for a class name that doesn't exist
    expect(
      () => findClassMirror('DoesNotExist', 'annotated.test.lib.search'),
      throwsArgumentError,
    );

    // Search for a library that doesn't exist
    expect(
      () => findClassMirror('DoesNotExist', 'does.not.exist'),
      throwsArgumentError,
    );
  });
}
