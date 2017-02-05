// Copyright (c) 2017, the Craft Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

import 'symbols.dart' as symbol;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Searches for a class mirror with the given [name].
///
/// If a [library] name is given then this will narrow down the search for the
/// class mirror. It is not a requirement unless the class name is not unique
/// within the loaded libraries.
///
/// An [ArgumentError] will be thrown if a class with the given [name] is not
/// found.
ClassMirror findClassMirror(String name, [String library = '']) =>
    library.isNotEmpty
        ? _classMirrorInLibrary(name, library)
        : _findClassMirror(name);

/// Finds the class mirror using its [name] within the [library].
ClassMirror _classMirrorInLibrary(String name, String library) {
  // Find the specified library
  var libraryMirror;

  try {
    libraryMirror =
        currentMirrorSystem().findLibrary(symbol.fromString(library));
  } catch (e) {
    throw new ArgumentError.value(
      library,
      'library',
      'Was not found within the mirrors system',
    );
  }

  // Search for the class
  final mirror = libraryMirror.declarations[symbol.fromString(name)];

  if (mirror == null) {
    throw new ArgumentError.value(
      name,
      'name',
      'Was not found within $library',
    );
  } else if (mirror is! ClassMirror) {
    throw new ArgumentError.value(name, 'name', 'Does not refer to a class');
  }

  return mirror as ClassMirror;
}

/// Searches the currently loaded libraries for a class with the given [name].
ClassMirror _findClassMirror(String name) {
  final classSymbol = symbol.fromString(name);
  var mirror;

  // Iterate over all libraries within the mirrors system
  for (var library in currentMirrorSystem().libraries.values) {
    mirror = library.declarations[classSymbol];

    if (mirror != null) {
      break;
    }
  }

  if (mirror == null) {
    throw new ArgumentError.value(
      name,
      'name',
      'Was not found within the mirrors system',
    );
  } else if (mirror is! ClassMirror) {
    throw new ArgumentError.value(name, 'name', 'Does not refer to a class');
  }

  return mirror as ClassMirror;
}
