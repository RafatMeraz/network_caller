import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'logger.dart';
import 'request_return_object.dart';

class BaseNetworkCaller {
  BaseNetworkCaller._internal();

  /// get api caller
  static Future<NetworkCallerReturnObject> getRequest(String url,
      {String? token, VoidCallback? onUnAuthorized}) async {
    try {
      Uri uri = Uri.parse(url);
      final request = http.MultipartRequest('GET', uri);
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        final decodedJson = json.decode(responseData);
        logger.w(decodedJson);
        return NetworkCallerReturnObject(
            errorMessage: '',
            returnValue: decodedJson,
            success: true,
            responseCode: response.statusCode);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) onUnAuthorized();
        return NetworkCallerReturnObject(
            errorMessage: 'Response code ${response.statusCode}',
            returnValue: '',
            success: false,
            responseCode: response.statusCode);
      } else {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        final decodedJson = json.decode(responseData);
        logger.w(decodedJson);
        logger.e(e);
        return NetworkCallerReturnObject(
            errorMessage: 'Response code ${response.statusCode}',
            returnValue: decodedJson,
            success: false,
            responseCode: response.statusCode);
      }
    } catch (e) {
      return NetworkCallerReturnObject(
          errorMessage: e.toString(),
          returnValue: "",
          success: false,
          responseCode: 400);
    }
  }

  /// post api caller
  static Future<NetworkCallerReturnObject> postRequest(
      String url, Map<String, dynamic> data,
      {String? token,
      Iterable<http.MultipartFile>? images,
        VoidCallback? onUnAuthorized,
      bool? isLogin}) async {
    try {
      logger.wtf(data);
      logger.wtf(url);
      Uri uri = Uri.parse(url);
      final request = http.Request('POST', uri);
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      if (token != null) request.headers['Authorization'] = 'Bearer $token';
      request.body = json.encode(data);
      final response = await request.send();
      logger.w(token);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        final decodedJson = json.decode(responseData);
        logger.w(decodedJson);
        return NetworkCallerReturnObject(
            errorMessage: '',
            returnValue: decodedJson,
            success: true,
            responseCode: response.statusCode);
      } else if (response.statusCode == 401) {
        if (isLogin != true) {
          if (onUnAuthorized != null) onUnAuthorized();
        }
        return NetworkCallerReturnObject(
            errorMessage: 'Unauthorized',
            returnValue: '',
            success: false,
            responseCode: response.statusCode);
      } else {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        final decodedJson = json.decode(responseData);
        logger.w(decodedJson);
        return NetworkCallerReturnObject(
            errorMessage: 'Status code ${response.statusCode}',
            returnValue: decodedJson,
            success: false,
            responseCode: response.statusCode);
      }
    } catch (e) {
      return NetworkCallerReturnObject(
          errorMessage: e.toString(),
          returnValue: "",
          success: false,
          responseCode: 400);
    }
  }

  /// post api caller
  static Future<NetworkCallerReturnObject> postMultiPartRequest(
      String url, Map<String, String> data,
      {String? token,
      Iterable<http.MultipartFile>? images,
      VoidCallback? onUnAuthorized}) async {
    try {
      logger.wtf(data);
      Uri uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri);
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      if (token != null) request.headers['Authorization'] = 'Bearer $token';
      request.fields.addAll(data);
      logger.w('---${images!.length}');
      request.files.addAll(images);
      logger.i(request.files);
      final response = await request.send();
      logger.w(response.statusCode);
      logger.w(token);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        final decodedJson = json.decode(responseData);
        logger.w(decodedJson);
        return NetworkCallerReturnObject(
            errorMessage: '',
            returnValue: decodedJson,
            success: true,
            responseCode: response.statusCode);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) onUnAuthorized();
        return NetworkCallerReturnObject(
            errorMessage: 'Response code ${response.statusCode}',
            returnValue: '',
            success: false,
            responseCode: response.statusCode);
      } else {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        final decodedJson = json.decode(responseData);
        logger.w(decodedJson);
        return NetworkCallerReturnObject(
            errorMessage: 'Status code ${response.statusCode}',
            returnValue: decodedJson,
            success: false,
            responseCode: response.statusCode);
      }
    } catch (e) {
      logger.e(e);
      return NetworkCallerReturnObject(
          errorMessage: e.toString(),
          returnValue: "",
          success: false,
          responseCode: 400);
    }
  }
}
