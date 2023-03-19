import 'dart:developer';

import 'package:postgres/postgres.dart';

class AppDatabase {
  String buyerEmailValue = '';
  String sellerEmailValue = '';
  String passwordValue = '';
  String mobileValue = '';
  String companyNameValue = '';
  String landlineValue = '';
  String fNameValue = '';
  String lNameValue = '';

  PostgreSQLConnection? connection;
  PostgreSQLResult? newSellerRegisterResult, newBuyerRegisterResult;
  PostgreSQLResult? sellerAlreadyRegistered, buyerAlreadyRegistered;

  PostgreSQLResult? loginResult, userRegisteredResult;

  PostgreSQLResult? updateBuyerResult;
  PostgreSQLResult? updateSellerResult;

  static String? sellerEmailAddress, buyerEmailAddress;

  PostgreSQLResult? _fetchSellerDataResult;

  AppDatabase() {
    connection = (connection == null || connection!.isClosed == true
        ? PostgreSQLConnection(
            // for external device like mobile phone use domain.com or
            // your computer machine IP address (i.e,192.168.0.1,etc)
            // when using AVD add this IP 10.0.2.2
            '10.0.2.2',
            5432,
            'rathandevaki',
            username: 'rathandevaki',
            password: '',
            timeoutInSeconds: 30,
            queryTimeoutInSeconds: 30,
            timeZone: 'UTC',
            useSSL: false,
            isUnixSocket: false,
          )
        : connection);

    fetchDataFuture = [];
  }

  String newBuyerFuture = '';
  Future<String> registerData(String name, String wife, String address) async {
    try {
      await connection!.open();
      await connection!.transaction((newConn) async {
        newBuyerRegisterResult = await newConn.query(
          'insert into myAppData.land_conversion (applicant_name,bin,address)'
          'values(@nameValue,@wifeValue,@addressValue)',
          substitutionValues: {
            'nameValue': name,
            'wifeValue': wife,
            'addressValue': address,
          },
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        newBuyerFuture =
            (newBuyerRegisterResult!.affectedRowCount > 0 ? 'reg' : 'nop');
      });
    } catch (exc) {
      log(exc.toString());

      newBuyerFuture = 'exc';
    }
    return newBuyerFuture;
  }

  //Login Database Section
  String userLoginFuture = '';
  Future<String> loginUser(String email, String password) async {
    try {
      await connection!.open();
      await connection!.transaction((loginConn) async {
        //Step 1 : Check email registered or no
        loginResult = await loginConn.query(
          'select emailDB,passDB,isSellerDB from myAppData.register where emailDB = @emailValue order by idDB',
          substitutionValues: {'emailValue': email},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (loginResult!.affectedRowCount > 0) {
          // Usually we check if account expired or no ...but I will
          // not add the code and skip here to simplify things
          // We will check the entered credentials..and decide
          // weather the user is a buyer or seller

          sellerEmailAddress = loginResult!.first
              .elementAt(0); //This to use when update seller details

          if (loginResult!.first.elementAt(1).contains(password) == true &&
              loginResult!.first.elementAt(2) == true) {
            userLoginFuture = 'sel';
          } else if (loginResult!.first.elementAt(1).contains(password) ==
                  true &&
              loginResult!.first.elementAt(2) == false) {
            userLoginFuture = 'buy';
          } else if (loginResult!.first.elementAt(1).contains(password) ==
              false) {
            userLoginFuture = 'fai';
          } else {
            userLoginFuture = 'exc';
          }
        } else {
          userLoginFuture = 'not';
        }
      });
    } catch (exc) {
      userLoginFuture = 'exc';
      exc.toString();
    }
    return userLoginFuture;
  }

  // Fetch Data Section
  List<dynamic> fetchDataFuture = [];
  Future<List<dynamic>> fetchSellerData(String emailText) async {
    try {
      await connection!.open();
      await connection!.transaction((fetchDataConn) async {
        _fetchSellerDataResult = await fetchDataConn.query(
          'select companydb,emaildb,fnamedb,mobiledb,avatar from myAppData.register where emailDB = @emailValue order by idDB',
          substitutionValues: {'emailValue': emailText},
          allowReuse: false,
          timeoutInSeconds: 30,
        );
        if (_fetchSellerDataResult!.affectedRowCount > 0) {
          fetchDataFuture =
              _fetchSellerDataResult!.first.toList(growable: true);
        } else {
          fetchDataFuture = [];
        }
      });
    } catch (exc) {
      fetchDataFuture = [];
      exc.toString();
    }

    return fetchDataFuture;
  }
}
