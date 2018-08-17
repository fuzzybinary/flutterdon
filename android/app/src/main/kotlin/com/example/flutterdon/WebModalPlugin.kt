package com.example.flutterdon

import android.app.Activity
import android.os.Build
import android.view.ViewGroup
import android.webkit.CookieManager
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import com.example.flutterdon.R

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar

class WebModalPlugin(val activity: Activity): MethodCallHandler {

  companion object {
    const val WEBVIEW_CHANNEL = "plugins.flutter.io/webmodal"

    @JvmStatic
    fun registerWith(registrar: Registrar): Unit {
      val channel = MethodChannel(registrar.messenger(), WEBVIEW_CHANNEL)
      channel.setMethodCallHandler(WebModalPlugin(registrar.activity()))
    }
  }

  private var webViewFrame: FrameLayout? = null
  private var webView: WebView? = null

  override fun onMethodCall(call: MethodCall, result: Result) {
    if(call.method == "present") {
      val url = call.argument("url") as String
      webView = WebView(activity)
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        val cookieManager = CookieManager.getInstance()
        cookieManager.setAcceptThirdPartyCookies(webView, true)
      }
      webView?.setWebViewClient(WebViewClient())

      webViewFrame = FrameLayout(activity)
      webViewFrame?.setBackgroundColor(activity.resources.getColor(R.color.mastodon_purple))
      webViewFrame?.setFitsSystemWindows(true)
      webViewFrame?.addView(webView)
      activity.addContentView(webViewFrame,
        ViewGroup.LayoutParams(
          ViewGroup.LayoutParams.MATCH_PARENT, 
          ViewGroup.LayoutParams.MATCH_PARENT
        )
      )
      webView?.loadUrl(url)

    } else if(call.method == "close") {
      webViewFrame?.let {
        activity.findViewById<ViewGroup>(android.R.id.content)?.removeView(it)
        webViewFrame = null
        webView = null
      }

      result.success(null)
    } else {
      result.notImplemented()
    }
  }
}