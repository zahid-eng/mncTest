package com.example.mnctest

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import id.mncinnovation.face_detection.MNCIdentifier
import id.mncinnovation.face_detection.MNCIdentifier.getLivenessIntent
import id.mncinnovation.face_detection.MNCIdentifier.setDetectionModeSequence
import id.mncinnovation.face_detection.SelfieWithKtpActivity
import id.mncinnovation.face_detection.analyzer.DetectionMode
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "liveness.face.detection/face"
    private lateinit var _result: MethodChannel.Result
    var LIVENESS_DETECTION_REQUEST_CODE = 101
    var CAPTURE_EKTP_REQUEST_CODE = 102
    var SCAN_KTP_REQUEST_CODE = 103
    var SELFIE_WITH_KTP_REQUEST_CODE = 104


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        fun startFaceDetection(){
            setDetectionModeSequence(true, Arrays.asList(DetectionMode.HOLD_STILL,DetectionMode.SHAKE_HEAD))
            startActivityForResult(MNCIdentifier.getLivenessIntent(this), LIVENESS_DETECTION_REQUEST_CODE)
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            // This method is invoked on the main thread.
            if (call.method == "startFaceDetection") {
                _result = result;
               startFaceDetection()
            } else {
                result.notImplemented()
            }
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK) {
            when (requestCode) {
                LIVENESS_DETECTION_REQUEST_CODE -> {
                    //get liveness result
                    val livenessResult = MNCIdentifier.getLivenessResult(data)
                    livenessResult?.let { result ->
                        if (result.isSuccess) {
                            val detectionResults = result.detectionResult!!;
                            val res = detectionResults.map { r -> r.image.toString() }; // detectionResults[0].image.toString();
                            _result.success(res);// check if liveness detection success
                            // get image result
                            val bitmap = result.getBitmap(this, DetectionMode.SMILE)
                        } else {  //Liveness Detection Error
                            //get Error Message
                            val errorMessage = result.errorMessage
                        }
                    }
                }
            }
        }
    }
}




