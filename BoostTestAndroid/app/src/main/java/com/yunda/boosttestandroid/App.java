package com.yunda.boosttestandroid;

import android.app.Application;
import android.content.Intent;
import android.util.Log;
import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostDelegate;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;
import io.flutter.embedding.android.FlutterActivityLaunchConfigs;

public class App extends Application {
    private static final String TAG = "MyApp";
    @Override
    public void onCreate() {
        super.onCreate();
        FlutterBoost.instance().setup(this, new FlutterBoostDelegate() {
            @Override
            public void pushNativeRoute(FlutterBoostRouteOptions options) {
                Log.d(TAG, "pushNativeRoute: " + options.pageName());
                //这里根据options.pageName来判断你想跳转哪个页面，这里简单给一个
                Intent intent = new Intent(FlutterBoost.instance().currentActivity(), FlutterNativeActivity.class);
                FlutterBoost.instance().currentActivity().startActivityForResult(intent, options.requestCode());
            }

            @Override
            public void pushFlutterRoute(FlutterBoostRouteOptions options) {
                Log.d(TAG, "pushFlutterRoute: " + options.pageName());
                Intent intent = new FlutterBoostActivity
                        .CachedEngineIntentBuilder(FlutterBoostActivity.class)
                        .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.opaque)
                        .destroyEngineWithActivity(false)
                        .uniqueId(options.uniqueId())
                        .url(options.pageName())
                        .urlParams(options.arguments())
                        .build(FlutterBoost.instance().currentActivity());
                FlutterBoost.instance().currentActivity().startActivity(intent);
            }
        }, engine -> {
            Log.d(TAG, "engine init success");
        });
    }
}
