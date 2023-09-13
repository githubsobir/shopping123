import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_body.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainBody {

  Future<ModelMainBody> getCarouselData({required String data}) async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseClass.url}/api/v1/web/banners/");
    // log(jsonEncode(response.data).toString());
    return ModelMainBody.fromJson(response.data);
  }

  var dio = Dio();
  late Response response;
  ModelProductList modelProductList = ModelProductList(
      count: "", next: "", previous: "", results: []);

  Future<List<ResultProductList>> getInfiniteList(
      {required ModelSearch modelSearch}) async {
    try {
      log(jsonEncode(modelSearch).toString());
      response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${getLinkSearch(
              m: modelSearch)}",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));

      modelProductList = ModelProductList.fromJson(response.data);
      // return jsonEncode(response.data).toString();
      log(jsonEncode(response.data).toString());
      return modelProductList.results;
    } catch (e) {
      return [];
    }
  }

  String getLinkSearch({required ModelSearch m}) {
    String data = "";
    try {
      if (m.minPrice.toString() != "null" && m.minPrice
          .toString()
          .isNotEmpty) {
        data = "min_price=${m.minPrice}";
      }
      if (m.maxPrice.toString() != "null" && m.maxPrice
          .toString()
          .isNotEmpty) {
        data = "max_price=${m.maxPrice}";
      }
      if (m.price.toString() != "null" && m.price
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&price=${m.price}";
        } else {
          data = "price=${m.price}";
        }
      }
      if (m.organization.toString() != "null" &&
          m.organization
              .toString()
              .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&organization=${m.organization}";
        } else {
          data = "organization=${m.organization}";
        }
      }
      if (m.brand.toString() != "null" && m.brand
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&brand=${m.brand}";
        } else {
          data = "brand=${m.brand}";
        }
      }
      if (m.category.toString() != "null" && m.category
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&category=${m.category}";
        } else {
          data = "category=${m.category}";
        }
      }
      if (m.categorySlug.toString() != "null" &&
          m.categorySlug
              .toString()
              .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&category_slug=${m.categorySlug}";
        } else {
          data = "category_slug=${m.categorySlug}";
        }
      }
      if (m.material.toString() != "null" && m.material
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&material=${m.material}";
        } else {
          data = "material=${m.material}";
        }
      }
      if (m.color.toString() != "null" && m.color
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&color=${m.color}";
        } else {
          data = "color=${m.color}";
        }
      }
      if (m.size.toString() != "null" && m.size
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&size=${m.size}";
        } else {
          data = "size=${m.size}";
        }
      }
      if (m.type.toString() != "null" && m.type
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&type=${m.type}";
        } else {
          data = "type=${m.type}";
        }
      }
      if (m.season.toString() != "null" && m.season
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&season=${m.season}";
        } else {
          data = "season=${m.season}";
        }
      }
      if (m.gender.toString() != "null" && m.gender
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&gender=${m.gender}";
        } else {
          data = "gender=${m.gender}";
        }
      }
      if (m.search.toString() != "null" && m.search
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&search=${m.search}";
        } else {
          data = "search=${m.search}";
        }
      }
      if (m.ordering.toString() != "null" && m.ordering
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&ordering=${m.ordering}";
        } else {
          data = "ordering=${m.ordering}";
        }
      }
      if (m.page.toString() != "null" && m.page
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&page=${m.page}";
        } else {
          data = "page=${m.page}";
        }
      }
      if (m.pageSize.toString() != "null" && m.pageSize
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&page_size=${m.pageSize}";
        } else {
          data = "page_size=${m.pageSize}";
        }
      }
      if (m.sessionId.toString() != "null" &&
          m.sessionId
              .toString()
              .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&session_id=${m.sessionId}";
        } else {
          data = "session_id=${m.sessionId}";
        }
      }
      if (m.lang.toString() != "null" && m.lang
          .toString()
          .isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&lang=${m.lang}";
        } else {
          data = "lang=${m.lang}";
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return data;
  }
}
