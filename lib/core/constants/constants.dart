import 'package:flutter/material.dart';

class AppConst {
  AppConst._();

  static double kWidth = 375;
  static double kHeight = 835;
  static double kRadius = 12;
}

const int pendingProductLimit = 10;
const int checkedProductLimit = 7;

// ignore: constant_identifier_names
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

const cachedProducts = 'CACHED_PRODUCTS';
