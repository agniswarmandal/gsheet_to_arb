// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

import '_messages_en.dart' deferred as messages_en;
import '_messages_de.dart' deferred as messages_de;
import '_messages_pl.dart' deferred as messages_pl;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'en': () => messages_en.loadLibrary(),
  'de': () => messages_de.loadLibrary(),
  'pl': () => messages_pl.loadLibrary(),
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case 'en':
      return messages_en.messages;
    case 'de':
      return messages_de.messages;
    case 'pl':
      return messages_pl.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => _deferredLibraries[locale] != null,
    onFailure: (_) => null);
  if (availableLocale == null) {
    // ignore: unnecessary_new
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  // ignore: unnecessary_new
  await (lib == null ? new Future.value(false) : lib());
  // ignore: unnecessary_new
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  // ignore: unnecessary_new
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
