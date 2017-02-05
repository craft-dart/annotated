// Copyright (c) 2017, the Craft Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'mirrors/class_mirrors_test.dart' as class_mirrors_test;
import 'mirrors/library_mirrors_test.dart' as library_mirrors_test;
import 'mirrors/variable_mirrors_test.dart' as variable_mirrors_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  group('ClassMirror', class_mirrors_test.main);
  group('LibraryMirror', library_mirrors_test.main);
  group('VariableMirror', variable_mirrors_test.main);
}
