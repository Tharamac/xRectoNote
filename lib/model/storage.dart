import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:x_rectonote/model/project_entity.dart';

class SongProjectStorage {
  static final SongProjectStorage _storage = SongProjectStorage._internal();
  factory SongProjectStorage() => _storage;
  SongProjectStorage._internal();

  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/storage.json");
  }

  Future<File> saveSongProjectList(List<SongProject> state) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(state));
  }

  Future<List<SongProject>> readSongProjectList() async {
    try {
      final file = await _localFile;
      String content = await file.readAsString();
      var decode = jsonDecode(content) as List;
      return decode.map((e) => SongProject.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}
