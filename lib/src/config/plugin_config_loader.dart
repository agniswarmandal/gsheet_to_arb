/*
 * Copyright (c) 2018, Marcin Marek Gocał
 * All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:io';

import '../utils/file_utils.dart';
import 'package:yaml/yaml.dart';

import 'plugin_config.dart';

class PluginConfigLoader {
  PluginConfig fromYamlFile(String filePath) {
    var yaml = _loadYamlFile(filePath);
    var map = jsonDecode(jsonEncode(yaml));
    var config = PluginConfigRoot.fromJson(map).config;
    _validate(config);
    return config;
  }

  YamlMap _loadYamlFile(String path) {
    var configFile = File(path);
    var configText = configFile.readAsStringSync();
    var yaml = loadYaml(configText);
    return yaml;
  }

  void _validate(PluginConfig config) {
    _validateAuth(config.sheetConfig.auth);
  }

  void _validateAuth(Auth auth) {
    if (auth.oauthClientId == null &&
        auth.oauthClientIdPath == null &&
        auth.serviceAccountKey == null &&
        auth.serviceAccountKeyPath == null) {
      throw Exception("Missing auth configuration");
    }

    if (auth.oauthClientId == null && auth.oauthClientIdPath != null) {
      var config = FileUtils.getFileContentSync(auth.oauthClientIdPath);
      auth.oauthClientId = OAuthClientId.fromJson(jsonDecode(config));
    }

    if (auth.serviceAccountKey == null && auth.serviceAccountKeyPath != null) {
      var config = FileUtils.getFileContentSync(auth.serviceAccountKeyPath);
      auth.serviceAccountKey = ServiceAccountKey.fromJson(jsonDecode(config));
    }
  }
}
