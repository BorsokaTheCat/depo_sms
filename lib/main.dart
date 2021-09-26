import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SmsModel>(create: (_) => SmsModel()),
        //ChangeNotifierProvider<VehiclesModel>(create: (_) => VehiclesModel()),
        //Provider<AnotherThing>(create: (_) => AnotherThing()),
      ],
      child:MaterialApp(/*
        theme: ThemeData(
//roboto
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 28.0,color: darkGrey, fontWeight: FontWeight.w600),
            headline2: TextStyle(fontSize: 24.0,color: darkGrey, fontWeight: FontWeight.w700),
            headline3: TextStyle(fontSize: 22.0,color: darkGrey, fontWeight: FontWeight.w700),
            headline4: TextStyle(fontSize: 20.0,color: darkGrey, fontWeight: FontWeight.w600),
            headline5: TextStyle(fontSize: 18.0,color: darkGrey, fontWeight: FontWeight.w600),
            headline6: TextStyle(fontSize: 16.0,color: darkGrey),
            subtitle1: TextStyle(fontSize: 18.0,color: darkGrey,),
            subtitle2: TextStyle(fontSize: 16.0,color: black,),
            bodyText1: TextStyle(fontSize: 14.0,color: darkGrey,),
            bodyText2: TextStyle(fontSize: 12.0,color: black,),),
        ),*/
        home: LoadingScreen(),
     /* ),*/));
  }

}
//smsSender.java
/*package com.babariviere.sms;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.provider.Telephony;
import android.telephony.SmsManager;
import android.util.Log;

import com.babariviere.sms.permisions.Permissions;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.UUID;
import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

import static io.flutter.plugin.common.PluginRegistry.Registrar;
import static io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

/**
 * Created by babariviere on 08/03/18.
 */

@TargetApi(Build.VERSION_CODES.DONUT)
class SmsSenderMethodHandler implements RequestPermissionsResultListener {
    private static final SmsManager sms = SmsManager.getDefault();
    private final String[] permissionsList = new String[]{Manifest.permission.SEND_SMS, Manifest.permission.READ_PHONE_STATE};
    private MethodChannel.Result result;
    private String address;
    private String body;
    private int sentId;
    private Integer subId;
    private final Registrar registrar;

    SmsSenderMethodHandler(Registrar registrar, MethodChannel.Result result, String address, String body, int sentId, Integer subId) {
        this.registrar = registrar;
        this.result = result;
        this.address = address;
        this.body = body;
        this.sentId = sentId;
        this.subId = subId;
    }

    void handle(Permissions permissions) {
        if (permissions.checkAndRequestPermission(permissionsList, Permissions.SEND_SMS_ID_REQ)) {
            sendSmsMessage();
        }
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if (requestCode != Permissions.SEND_SMS_ID_REQ) {
            return false;
        }
        boolean isOk = true;
        for (int res : grantResults) {
            if (res != PackageManager.PERMISSION_GRANTED) {
                isOk = false;
                break;
            }
        }
        if (isOk) {
            sendSmsMessage();
            return true;
        }
        result.error("#01", "permission denied for sending sms", null);
        return false;
    }

    @TargetApi(Build.VERSION_CODES.KITKAT)
    private void sendSmsMessage() {
        Intent sentIntent = new Intent("SMS_SENT");
        sentIntent.putExtra("sentId", sentId);
        PendingIntent sentPendingIntent = PendingIntent.getBroadcast(
                registrar.context(),
                0,
                sentIntent,
                PendingIntent.FLAG_UPDATE_CURRENT
        );

        Intent deliveredIntent = new Intent("SMS_DELIVERED");
        deliveredIntent.putExtra("sentId", sentId);
        PendingIntent deliveredPendingIntent = PendingIntent.getBroadcast(
                registrar.context(),
                UUID.randomUUID().hashCode(),
                deliveredIntent,
                PendingIntent.FLAG_UPDATE_CURRENT
        );
        SmsManager sms;
        if (this.subId == null) {
            sms = SmsManager.getDefault();
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                sms = SmsManager.getSmsManagerForSubscriptionId(this.subId);
            } else {
                result.error("#03", "this version of android does not support multicard SIM", null);
                return;
            }
        }
        ArrayList<PendingIntent> sentPendingIntents = new ArrayList<PendingIntent>();
        ArrayList<PendingIntent> deliveredPendingIntents = new ArrayList<PendingIntent>();
        PendingIntent sentPI = PendingIntent.getBroadcast(registrar.context(), 0,
                            sentIntent, 0);

        PendingIntent deliveredPI = PendingIntent.getBroadcast(registrar.context(),0,
                            deliveredIntent,  0);
        try {
            ArrayList<String> mSMSMessage = sms.divideMessage(body);
            for (int i = 0; i < mSMSMessage.size(); i++) {
                sentPendingIntents.add(i, sentPI);

                deliveredPendingIntents.add(i, deliveredPI);
            }
        sms.sendMultipartTextMessage(address, null, mSMSMessage,
                sentPendingIntents, deliveredPendingIntents);
        } catch (Exception e) {

               e.printStackTrace();

        }
        result.success(null);
    }
}

@TargetApi(Build.VERSION_CODES.DONUT)
class SmsSender implements MethodCallHandler {
    private final Registrar registrar;
    private final Permissions permissions;

    SmsSender(Registrar registrar) {
        this.registrar = registrar;
        permissions = new Permissions(registrar.activity());
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("sendSMS")) {
            String address = call.argument("address").toString();
            String body = call.argument("body").toString();
            int sentId = call.argument("sentId");
            Integer subId = call.argument("subId");
            if (address == null) {
                result.error("#02", "missing argument 'address'", null);
            } else if (body == null) {
                result.error("#02", "missing argument 'body'", null);
            } else {
                SmsSenderMethodHandler handler = new SmsSenderMethodHandler(registrar, result, address, body, sentId, subId);
                this.registrar.addRequestPermissionsResultListener(handler);
                handler.handle(this.permissions);
            }
        } else {
            result.notImplemented();
        }
    }
}
*/
