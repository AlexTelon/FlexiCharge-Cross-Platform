import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../../../services/user_api_service.dart';

class SetupInvoicingViewmodel extends BaseViewModel {
  bool _checked = false;
  bool _isValid = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  Future<Set> validateSetupInvoice(
      String name, String address, String postcode, String town) async {
    try {
      _isValid = true; //await UserApiService().verifyLogin(username, password);
    } catch (error) {
      var invoiceSetupSuccess = {false, error.toString()};
      return invoiceSetupSuccess;
    }
    var invoiceSetupSuccess = {_isValid, ""};
    return invoiceSetupSuccess;
  }
}

class UserInvoiceSetupApiService {
  static const String baseURL =
      "http://18.202.253.30:8080"; //Live FlexiCharge API

  static final Uri invoiceSetup = Uri.parse(baseURL + "/invoice-setup");
}




/*
{"info":
  {"_postman_id":"a6f4557a-797f-4188-ac5c-003a2ff47de0",
    "name":"User","description":"Create a new user with the \"Sign-up\" request. The registered 
    user will get a email with a verification code. Use this verification code with 
    the \"Verify user\" request. When verified sign in with the \"Sign-in\" request to get a 
    access token.",
    "schema":"https://schema.getpostman.com/json/collection/v2.0.0/collection.json"},
  "item":[
    {"name":"Sign-in","id":"f0e7d223-751e-491c-a7e8-4ea43753e59c",
      "request":{"method":"POST","header":[],
        "body":{"mode":"raw","raw":"{\r\n    \"username\": \"rest-api-user\",\r\n    \"password\": \"{{rest-api-account-password}}\"\r\n}",
        "options":{"raw":{"language":"json"}}},
        "url":"{{url}}/auth/sign-in"},
    "response":[]},
    {"name":"Sign-up","id":"68d4544d-c637-4e63-b360-63b49b20581a",
    "request":{"method":"POST","header":[],"body":{"mode":"raw","raw":"{\r\n    \"username\": \"username\",\r\n    \"password\": \"password\",\r\n    \"email\": \"email@email.com\",\r\n    \"name\": \"first_name\",\r\n    \"family_name\": \"last_name\"\r\n}",
      "options":{"raw":{"language":"json"}}},
      "url":"{{url}}/auth/sign-up",
      "description":"Creates a new user. Sends a verification code in a email to the supplied email 
      address. Use this verification code with the \"Verify user\" request."},"response":[]
      },
    {"name":"Verify user","id":"11be9812-41d4-4936-b2a2-c3bada03c405",
      "request":{"method":"POST","header":[],"body":{"mode":"raw","raw":"{\r\n    \"username\": \"username\",\r\n    \"code\": \"verification_code\"\r\n}",
        "options":{"raw":{"language":"json"}}},"url":"{{url}}/auth/verify",
        "description":"Verifies a new user account with a verification code."},
        "response":[]},
    {"name":"Change password","id":"d23ea084-d6d4-4137-9654-3c106db157e6",
      "request":{"method":"POST","header":[],"url":null},"response":[]},
    {"name":"Confirm forgot password","id":"13272264-93ab-4b3f-b99c-169d4905b285",
      "request":{"method":"POST","header":[],"body":{"mode":"raw","raw":"{\n    \"username\": \"rest-api-user\",\n    \"password\": \"{{rest-api-account-password}}\",\n    \"confirmationCode\": \"email_code\"\n}","options":{"raw":{"language":"json"}}},
        "url":"{{url}}/auth/confirm-forgot-password"},
        "response":[]},
    {"name":"Forgot password","id":"000ab64d-0c0e-48f4-ba9b-3e4cbf5e1238",
      "request":{"method":"POST","header":[],"url":"{{url}}/auth/forgot-password/username"},
      "response":[]}
  ],
  "variable":[
    {"id":"90393661-dca2-4dea-b1e2-a202563aa255","key":"url","value":"localhost:8080"}
    ]
}

*/

/*
{"info":
  {"_postman_id":"efa17d70-c010-4303-8601-5be596a2fa1b",
    "name":"Chargers","schema":"https://schema.getpostman.com/json/collection/v2.0.0/collection.json"
  },
  "item":[
    {"name":"Chargers","id":"cee74a05-4e54-4b1b-8cd7-7248070db109",
      "request":{"method":"GET","header":[],"url":"{{url}}/chargers"},"response":[]
    },
    {"name":"Chargers","id":"8eb43b92-1a12-48e9-985f-5f7e79416849",
      "request":{
        "auth": {"type":"bearer","bearer":{"token":""}},
        "method":"POST","header":[],
        "body":{"mode":"raw","raw":"{\r\n    \"chargePointID\": 24,\r\n    \"location\": [57.777714, 14.16301],\r\n    \"serialNumber\": \"testnumber15\"\r\n}",
          "options":{"raw":{"language":"json"}}
        },
        "url":"{{url}}/chargers"
      },
      "response":[]
    },
    {"name":"Available chargers","id":"0fff822a-d785-4e17-ba90-8aac0c625495",
      "request":{"method":"GET","header":[],"url":"{{url}}/chargers/available"},
      "response":[]},
    {"name":"Charger by id","id":"d80eb9a5-1032-43be-99e4-fdc36fc3f482",
      "request":{"method":"GET","header":[],"url":"{{url}}/chargers/100015"},
      "response":[]
    },
    {"name":"Charger by serial number","id":"ef656bef-3663-4d71-bf85-a6e21b442eee",
      "request":{"method":"GET","header":[],"url":"{{url}}/chargers/serial/NEWCHARGER1A"},
      "response":[]
    },
    {"name":"Update charger","id":"319451f2-085f-48f6-977a-982110bf1b39",
      "request":{"auth":{"type":"bearer","bearer":{"token":""}},
        "method":"PUT","header":[],
        "body":{"mode":"raw","raw":"{\n    \"status\": \"Available\"\n}",
          "options":{"raw":{"language":"json"}}
        },
        "url":"{{url}}/chargers/100010"
      },
      "response":[]
    }
  ]
}

*/