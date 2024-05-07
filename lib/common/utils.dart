import 'package:flutter/material.dart';

const defaultscrollphysics = BouncingScrollPhysics();

extension PriceLable on int{
  String get withPriceLable => '$this تومان';
}