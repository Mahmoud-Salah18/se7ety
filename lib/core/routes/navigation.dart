import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future pushTo(BuildContext context, String route, {Object? extra}) {
  return context.push(route, extra: extra);
}

Future pushWithReplacement(
  BuildContext context,
  String route, {
  Object? extra,
}) async {
  context.pop();
  return context.push(route, extra: extra);
}

goToBase(BuildContext context, String route, {Object? extra}) {
  return context.go(route, extra: extra);
}

pop(BuildContext context) {
  return context.pop();
}
