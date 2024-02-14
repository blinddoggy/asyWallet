import 'package:flutter/material.dart';

class TransactionActionInfoDTO {
  final String label;
  final String route;
  final IconData icon;
  final VoidCallback? action;

  const TransactionActionInfoDTO({
    required this.label,
    required this.route,
    required this.icon,
    this.action,
  });
}
