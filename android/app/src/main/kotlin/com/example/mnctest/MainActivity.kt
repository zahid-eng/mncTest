package com.example.mnctest

import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.face.FaceDetection
import com.google.mlkit.vision.face.FaceDetectorOptions
import id.mncinnovation.face_detection.MNCIdentifier
import id.mncinnovation.face_detection.MNCIdentifier.setDetectionModeSequence
import id.mncinnovation.face_detection.analyzer.DetectionMode
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.util.*


class MainActivity: FlutterActivity() {
    private val faceDetector = FaceDetection.getClient()
    private val CHANNEL = "liveness.face.detection/face"
    private lateinit var _result: MethodChannel.Result
    var LIVENESS_DETECTION_REQUEST_CODE = 101
    var CAPTURE_EKTP_REQUEST_CODE = 102
    var SCAN_KTP_REQUEST_CODE = 103
    var SELFIE_WITH_KTP_REQUEST_CODE = 104


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }


    private fun convertImageToByteArrayAndProcess(filePath: String) {
        try {
            val file = File(filePath.split("file://")[1])
            val inputStream = FileInputStream(file)
            val byteArray = inputStream.readBytes()

            analyze(byteArray)

            inputStream.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        fun startFaceDetection(){

            //DetectionMode.SHAKE_HEAD
            setDetectionModeSequence(true, Arrays.asList(DetectionMode.HOLD_STILL))
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


     fun analyze(byteArray: ByteArray) {

        // val bmImg = BitmapFactory.decodeFile(filePath.split("file://")[1])

         val inputImage = InputImage.fromByteArray(
             byteArray,
             480,
             360,
            90,
             InputImage.IMAGE_FORMAT_BITMAP // or InputImage.IMAGE_FORMAT_YV12 depending on your image format
         )


         faceDetector.process(inputImage)
             .addOnSuccessListener { listFace ->
                 Log.v("FlutterActivity", "listFace=" + listFace);

              //   listener.onFaceDetectionSuccess(listFace)
             }
             .addOnFailureListener { exception ->

                 Log.v("FlutterActivity", "exception=" + exception);
              //   listener.onFaceDetectionFailure(exception)
             }
             .addOnCompleteListener {
               //  image.close()
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
                            val res = detectionResults.map { r -> r.image.toString() };

                           // Log.v("FlutterActivity", "image" + res[0]);

                            // detectionResults[0].image.toString();

                            convertImageToByteArrayAndProcess(res[0])

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




