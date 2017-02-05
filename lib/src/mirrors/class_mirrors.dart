// Copyright (c) 2017, the Craft Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Retrieves all const constructors on the class [mirror].
///
/// Only const constructors can produce annotations. This function searches the
/// contents of the class [mirror] to gather the listing.
Iterable<MethodMirror> classConstConstructors(ClassMirror mirror) sync* {
  for (var declaration in mirror.declarations.values) {
    if ((declaration is MethodMirror) && (declaration.isConstConstructor)) {
      yield declaration;
    }
  }
}

/// Retrieves all instance fields on the class [mirror] that are final.
///
/// All fields in an annotations need to be final otherwise a const constructor
/// cannot be used. This function searches through the contents of the class
/// [mirror] to gather the listing.
Iterable<VariableMirror> classFinalFields(ClassMirror mirror) sync* {
  for (var declaration in mirror.declarations.values) {
    if ((declaration is VariableMirror) &&
        (declaration.isFinal) &&
        (!declaration.isStatic)) {
      yield declaration;
    }
  }
}
