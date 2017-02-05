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

/// Converts from a symbol [name] to the equivalent [String].
String toString(Symbol name) => MirrorSystem.getName(name);

/// Converts from a string [name] to the equivalent [Symbol].
Symbol fromString(String name) => new Symbol(name);
