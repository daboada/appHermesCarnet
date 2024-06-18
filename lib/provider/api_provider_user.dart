import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// CALL API PROVIDER USER
class ApiProviderUser with ChangeNotifier {

  // FUNCTIONS

  // REQUEST - VALIDATE CREDENTIALS
  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://9vq3w22t-8080.use2.devtunnels.ms/api/v1/hermes/auth/user/login'),
      headers: { 'Content-Type': 'application/json',},
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );

    // CONDITIONAL IF THE RESPONSE BODY IS EMPTY
    dynamic body = response.body.isNotEmpty ? json.decode(response.body) : null;

    // RETURN A MAP WITH REQUEST STATE CODE AND BODY
    return {
      'statusCode': response.statusCode,
      'body': body,
    };
  }

  // REQUEST - DATA USER
  Future<Map<String, dynamic>> dataUser(String userName, String token) async {
    final response = await http.post(
      Uri.parse('https://9vq3w22t-8080.use2.devtunnels.ms/api/v1/hermes/user/people/$userName'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // CONDITIONAL IF THE RESPONSE BODY IS EMPTY
    dynamic body = response.body.isNotEmpty ? json.decode(response.body) : null;

    // RETURN A MAP WITH REQUEST STATE CODE AND BODY
    return {
      'statusCode': response.statusCode,
      'body': body,
    };
  }
}
