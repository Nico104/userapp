import 'package:flutter/material.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/pet_color/pet_colors.dart';
import '../pets/profile_details/models/m_pet_profile.dart';

Color getPageBackgroundColorMixture(Color color1, Color color2, double page) {
  double mixFactor = page - page.floor();
  return Color.alphaBlend(color1.withOpacity(1 - mixFactor), color2);
}

Color getColor(List<PetProfileDetails> list, double pageindex) {
  if (pageindex >= list.length) {
    pageindex = list.length - 1;
  }

  if (pageindex.floor() + 1 <= list.length - 1) {
    return getPageBackgroundColorMixture(
        list
            .elementAt(pageindex.floor())
            .tag
            .first
            .collarTagPersonalisation
            .petPageBackgroundColor,
        list
            .elementAt(pageindex.floor() + 1)
            .tag
            .first
            .collarTagPersonalisation
            .petPageBackgroundColor,
        pageindex);
  } else {
    return list
        .elementAt(pageindex.floor())
        .tag
        .first
        .collarTagPersonalisation
        .petPageBackgroundColor;
  }
}

Color getGenderBackgroundColor(Gender gender) {
  if (gender == Gender.male) {
    return genderBgBlue;
  } else {
    return genderBgPink;
  }
}
