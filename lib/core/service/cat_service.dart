import 'dart:convert';

import 'package:connectivity_bloc/core/constants/constants.dart';
import 'package:connectivity_bloc/core/models/cat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatApiService {
  const CatApiService();

  Future<List<CatModel>> getCats() async {
    try {
      final uri = Uri.https(
        AppConstants.baseUrl,
        AppConstants.searchEndPoint,
        {'limit': AppConstants.countPerFetch},
      );

      final response = await http.get(
        uri,
        headers: {
          'x-api-key': AppConstants.apiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final catList = <CatModel>[];

        catList.addAll((json as List<dynamic>).map((e) => CatModel.fromMap(e as Map<String, dynamic>)).toList());
        return catList;
      } else {
        throw Exception('Failed to load cat image');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to load cat image');
    }
  }
}
