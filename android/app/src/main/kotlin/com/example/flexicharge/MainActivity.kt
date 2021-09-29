package com.example.flexicharge

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (Intent.ACTION_VIEW.equals(intent.getAction())) {
        getFlutterView().pushRoute("paymentDone");
        }
    }
}


