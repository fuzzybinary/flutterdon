package com.yourcompany.flutterdon;

import android.os.Build;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowInsets;
import android.webkit.CookieManager;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import io.flutter.app.FlutterFragmentActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {

    private static final String WEBVIEW_CHANNEL = "plugins.flutter.io/webmodal";

    @Nullable
    private FrameLayout webViewFrame;
    @Nullable
    private WebView webView;
    @Nullable
    private MethodChannel.Result result;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        MethodChannel methodChannel = new MethodChannel(getFlutterView(), WEBVIEW_CHANNEL);
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (MainActivity.this.result != null) {
                    MainActivity.this.result.success(null);
                }
                MainActivity.this.result = result;
                switch (methodCall.method) {
                    case "present":
                        String url = methodCall.argument("url");
                        webView = new WebView(MainActivity.this);
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                            CookieManager cookieManager = CookieManager.getInstance();
                            cookieManager.setAcceptThirdPartyCookies(webView, true);
                        }
                        webView.setWebViewClient(new WebViewClient());
                        webViewFrame = new FrameLayout(MainActivity.this);
                        webViewFrame.setBackgroundColor(R.color.mastodon_purple);
                        webViewFrame.setFitsSystemWindows(true);
                        webViewFrame.addView(webView);
                        addContentView(webViewFrame, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
                        webView.loadUrl(url);
                        break;
                    case "close":
                        if (webViewFrame != null) {
                            ((ViewGroup) findViewById(android.R.id.content)).removeView(webViewFrame);
                            webViewFrame = null;
                            webView = null;
                        }
                        result.success(null);
                        break;
                }
            }
        });
    }

    @Override
    public void onBackPressed() {
        if (webView != null) {
            if (webView.canGoBack()) {
                webView.goBack();
            } else {
                ((ViewGroup) findViewById(android.R.id.content)).removeView(webViewFrame);
                webView = null;
                webViewFrame = null;
                if (result != null) {
                    result.success(null);
                    result = null;
                }
            }
        } else {
            super.onBackPressed();
        }
    }
}
