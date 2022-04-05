import 'dart:developer';

import 'package:flutter/material.dart';

import 'usage_criteria.dart';

class MenuDrawerItemModel implements UsageCriteria {
  final String screenId, assetImage, networkImage, title;
  final Widget screen;

  const MenuDrawerItemModel({
    this.screenId,
    this.assetImage,
    this.networkImage,
    this.title,
    this.screen,
  });

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in MenuDrawerItemModel.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return screenId != null && screen != null && title != null;
    } catch (e) {
      log('Exception in MenuDrawerItemModel.usable : $e');
      return false;
    }
  }
}
