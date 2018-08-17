package com.example.flutterdon

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity(): FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    WebModalPlugin.registerWith(this.registrarFor("com.example.flutterdon.WebModalPlugin"))
  }
}
