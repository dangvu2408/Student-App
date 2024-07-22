import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:shared_preferences/shared_preferences.dart';

class jsonData {
    Future<void> getTimeTable() async {
        try {
            final response = await http.get(
                Uri.parse('https://ctt-sis.hust.edu.vn/Students/Timetables.aspx'),
                headers: {
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                },
            );

            if (response.statusCode == 200) {
                final document = parse(response.body);
                await parseTimeTable(document);
            } else {
                print('Lỗi khi gửi request: ${response.statusCode}');
            }
        } catch (e) {
            print('Lỗi khi lấy thời khóa biểu: $e');
        }
    }

    Future<void> parseTimeTable(document) async {
        try {
            final jsonArray = [];
            final elements = document.getElementById('ctl00_ctl00_contentPane_MainPanel_MainContent_gvStudentRegister_DXMainTable')?.getElementsByClassName('dxgvDataRow_Mulberry');

            if (elements != null) {
                for (var element in elements) {
                    final str01 = element.querySelector('td.dxgv')?.text ?? '';
                    final str02 = element.querySelectorAll('td.dxgv')[1]?.text ?? '';
                    final str03 = element.querySelectorAll('td.dxgv')[2]?.text ?? '';
                    final str04 = element.querySelectorAll('td.dxgv')[3]?.text ?? '';
                    final str05 = element.querySelectorAll('td.dxgv')[4]?.text ?? '';
                    final str06 = element.querySelectorAll('td.dxgv')[5]?.text ?? '';
                    final str07 = element.querySelectorAll('td.dxgv')[6]?.text ?? '';
                    final str08 = element.querySelectorAll('td.dxgv')[7]?.text ?? '';
                    final str09 = element.querySelectorAll('td.dxgv')[8]?.text ?? '';
                    final str10 = element.querySelectorAll('td.dxgv')[9]?.text ?? '';
                    final str11 = element.querySelectorAll('td.dxgv')[10]?.text ?? '';
                    final str12 = element.querySelectorAll('td.dxgv')[11]?.text ?? '';
                    final str13 = element.querySelectorAll('td.dxgv')[12]?.text ?? '';

                    final jsonObject = {
                        'Thoi_gian': str01,
                        'Tuan_hoc': str02,
                        'Phong_hoc': str03,
                        'Ma_lop': str04,
                        'Loai_lop': str05,
                        'Nhom': str06,
                        'Ma_HP': str07,
                        'Ten_lop': str08,
                        'Ghi_chu': str09,
                        'Hinh_thuc_day': str10,
                        'Giang_vien': str11,
                        'Link_online': str12,
                        'Code_teams': str13,
                    };
                    jsonArray.add(jsonObject);
                }

              // Lưu dữ liệu vào SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('key_share_preferences_data_tkb', jsonEncode(jsonArray));
            }
        } catch (e) {
            print('Lỗi khi phân tích thời khóa biểu: $e');
        }
    }
}
