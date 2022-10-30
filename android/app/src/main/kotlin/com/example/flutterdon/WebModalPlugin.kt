package com.example.flutterdon

import android.app.Activity
import android.os.Build
import android.view.ViewGroup
import android.webkit.CookieManager
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import com.example.flutterdon.R
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall

class WebModalPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

  companion object {
    const val WEBVIEW_CHANNEL = "plugins.flutter.io/webmodal"
  }

  private lateinit var channel: MethodChannel
  private lateinit var binding: FlutterPlugin.FlutterPluginBinding

  private var activity: Activity? = null
  private var webViewFrame: FrameLayout? = null
  private var webView: WebView? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, WEBVIEW_CHANNEL)
    channel.setMethodCallHandler(this)

    this.binding = binding
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "present" -> {
          val url = call.argument<String>("url")
          if (url == null) {
            result.error("Bad Call", "URL can not be null.", null)
            return
          }

          webView = WebView(binding.applicationContext)
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val cookieManager = CookieManager.getInstance()
            cookieManager.setAcceptThirdPartyCookies(webView, true)
          }

          webView?.webViewClient = WebViewClient()

          webViewFrame = FrameLayout(binding.applicationContext)
          webViewFrame?.setBackgroundColor(binding.applicationContext.resources.getColor(R.color.mastodon_purple))
          webViewFrame?.fitsSystemWindows = true
          webViewFrame?.addView(webView)
          activity?.addContentView(webViewFrame,
            ViewGroup.LayoutParams(
              ViewGroup.LayoutParams.MATCH_PARENT,
              ViewGroup.LayoutParams.MATCH_PARENT
            )
          )
          webView?.loadUrl(url)

        }
        "close" -> {
          webViewFrame?.let {
            activity?.findViewById<ViewGroup>(android.R.id.content)?.removeView(it)
            webViewFrame = null
            webView = null
          }

          result.success(null)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}