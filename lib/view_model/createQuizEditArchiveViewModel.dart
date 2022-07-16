import 'package:flutter/material.dart';
import 'package:memorize/constants/appTextStyles.dart';
import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database_archive.dart';

abstract class CreateEditArchiveViewModel<T extends StatefulWidget> extends State<T> {
  ProjectKeys keys = ProjectKeys();
  AppTextStyles textStyles = AppTextStyles();

  ArchiveOperations archiveOperations = ArchiveOperations();

  /////////////////////////////////////////////////////
}