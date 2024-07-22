import 'package:flutter/cupertino.dart';
import 'package:hust_sa/data/sharedPreferences.dart';

import 'package:http/http.dart' as http;

class requestData {
    static final requestData res = requestData._internal();

    factory requestData() {
        return res;
    }

    requestData._internal();

    Future<bool> loginRequest(BuildContext context, String username, String password, String captcha, String loginCode, Map<String, String> cookies, int tmp) async {
        String string00 = '0_2944,1_67,1_68,1_69,0_2949,0_2,0_2860,1_206,0_2865,1_207,1_204,1_203,https://fonts.googleapis.com/css?family=Arimo,../Content/bootstrap/css/bootstrap.min.css,../Content/bootstrap/css/bootstrap-combobox.css,../Content/docs.min.css,../Content/Site.css';
        String string01 = '1_11,1_12,1_23,1_63,1_14,1_15,1_48,1_17,1_24,1_33,1_180,1_185,1_186,1_181,1_200,1_179,1_32';
        String string02 = "ctl00\$ctl00\$TopMenuPane\$ctl10\$menuTop";
        bool x = true;
        if (tmp == 0) {
            string00 = "0_2870,1_67,1_68,1_69,0_2875,0_2,0_2786,1_206,0_2791,1_207,1_204,1_203,https://fonts.googleapis.com/css?family=Arimo,../Content/bootstrap/css/bootstrap.min.css,../Content/bootstrap/css/bootstrap-combobox.css,../Content/docs.min.css,../Content/Site.css";
            string01 = "1_10,1_11,1_22,1_63,1_13,1_14,1_29,1_48,1_16,1_23,1_33,1_180,1_185,1_186,1_181,1_200,1_179,1_32";
        } else if (tmp == 1){
            string02 = "ctl00\$ctl00\$TopMenuPane\$ctl09\$menuTop";
        }

        try {
            String? viewState = await getViewState();
            String? eventValidation = await getEventValidation();
            if (viewState == null || eventValidation == null) {
                print('Lỗi: viewState hoặc eventValidation là null');
                return false;
            }
            print('Cookies: ${cookies.entries.map((e) => '${e.key}=${e.value}').join('; ')}');
            print('Login Code: $loginCode');
            var response = await http.post(
                Uri.parse('https://ctt-sis.hust.edu.vn/Account/Login.aspx'),
                headers: {
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
                    // 'Cookie': cookies.entries.map((e) => '${e.key}=${e.value}').join('; '),
                },
                body: {
                    '__EVENTTARGET': '',
                    '__EVENTARGUMENT': '',
                    '__VIEWSTATE': viewState,
                    '__VIEWSTATEGENERATOR': 'CD85D8D2',
                    '__EVENTVALIDATION': eventValidation,
                    'ctl00\$ctl00\$TopMenuPane\$menuTop': '{&quot;selectedItemIndexPath&quot;:&quot;&quot;,&quot;checkedState&quot;:&quot;&quot;}',
                    string02: '{&quot;selectedItemIndexPath&quot;:&quot;&quot;,&quot;checkedState&quot;:&quot;&quot;}',
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$chbParents': 'I',
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$tbUserName\$State': '{&quot;rawValue&quot;:&quot;$username&quot;,&quot;validationState&quot;:&quot;&quot;}',
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$tbUserName': username,
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$tbPassword\$State': '{&quot;rawValue&quot;:&quot;$password&quot;,&quot;validationState&quot;:&quot;&quot;}',
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$tbPassword': password,
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$ASPxCaptcha1\$TB\$State': '{&quot;validationState&quot;:&quot;&quot;}',
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$ASPxCaptcha1\$TB': captcha,
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$btLogin': '["0":"Đăng+nhập","1":""]',
                    'ctl00\$ctl00\$contentPane\$MainPanel\$MainContent\$hfInput': loginCode,
                    'DXScript': string01,
                    'DXCss': string00,
                },
            );

            if (response.statusCode != 200 && response.request?.url.toString() != 'https://ctt-sis.hust.edu.vn/') {
                return false;
            }

        } catch(e) {
            x = false;
            print('Lỗi request: $e');
            return x;
        }
        return x;
    }
}