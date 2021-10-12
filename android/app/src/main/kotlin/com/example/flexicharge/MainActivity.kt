package com.example.flexicharge

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import payment.KlarnaActivity

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.startActivity/klarnaChannel"
    var result:  MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)



    }


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method.equals("StartKlarnaActivity")){
                this.result = result
                //Log.d("lkasmdlkasmdmaksmdklamskldm", call.argument("clientToken"))
                val clientToken =  call.argument("clientToken") as String?
                if(clientToken != null){
                    val intent= Intent(this, KlarnaActivity::class.java)
                    intent.putExtra("CLIENTTOKEN", clientToken)
                    startActivityForResult(intent, 1)

                }
            }
            else{
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 1) {
            if (resultCode == RESULT_OK && this.result != null) {
                val result = data.getStringExtra("result")
                this.result!!.success(result)
            }
        }
        if (resultCode == RESULT_CANCELED) {
            // Write your code if there's no result

        }
    }
}
