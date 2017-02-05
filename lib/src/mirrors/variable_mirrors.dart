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

/// Retrieves the instance of the variable [mirror].
///
/// This function will only be successful under certain conditions.
///
/// * The value being referenced is const.
///
/// The function will assert if the conditions are not met. This is a function
/// for internal use so an assert makes sense here.
T getInstance<T>(VariableMirror mirror) {
  assert(mirror.isConst, 'The value needs to be const to get the instance');
  assert(mirror.owner is ObjectMirror, '');

  final owner = mirror.owner as ObjectMirror;

  return owner.getField(mirror.simpleName).reflectee as T;
}

/// Retrieves constant instances of [mirror].
///
/// By specifying [search] a specific library can be queried. Otherwise the
/// library containing the class [mirror] will be searched.
Iterable<VariableMirror> findConstInstancesOf(
  ClassMirror mirror, [
  LibraryMirror search,
]) =>
    _findConstInstancesOf(mirror, search ?? mirror.owner);

/// Retrieves constant instances of [mirror].
Iterable<VariableMirror> _findConstInstancesOf(
  ClassMirror mirror,
  Mirror search,
) sync* {
  final declarations = _getDeclarations(search);

  if (declarations.isEmpty) {
    if ((search is VariableMirror) &&
        (search.isConst) &&
        (search.type == mirror)) {
      yield search;
    }
  } else {
    for (var declaration in declarations) {
      yield* _findConstInstancesOf(mirror, declaration);
    }
  }
}

/// Retrieves the declarations on the [mirror].
///
/// Only [LibraryMirror] and [ClassMirror] contain a list of declarations. For
/// all other subclasses of [Mirror] an empty list will be returned.
Iterable<DeclarationMirror> _getDeclarations(Mirror mirror) {
  if (mirror is LibraryMirror) {
    return mirror.declarations.values;
  } else if (mirror is ClassMirror) {
    return mirror.declarations.values;
  } else {
    return new Iterable<DeclarationMirror>.empty();
  }
}
