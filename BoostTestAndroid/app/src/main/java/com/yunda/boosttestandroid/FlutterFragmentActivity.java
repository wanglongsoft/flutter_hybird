package com.yunda.boosttestandroid;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.idlefish.flutterboost.containers.FlutterBoostFragment;
import java.util.HashMap;
import java.util.Map;

public class FlutterFragmentActivity extends AppCompatActivity {
    private static final String TAG = "FlutterActivity";
    private FlutterBoostFragment boostFragment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d(TAG, "onCreate: ");
        StatusBarUtil.transparentStatusBar(this);
        StatusBarUtil.setStatusbarWhiteOrBlack(this, true);
        setContentView(R.layout.activity_flutter_fragment);
        Map map = new HashMap<String, Object>();
        map.put("data","FlutterBoostFragment to flutter");
        boostFragment = new FlutterBoostFragment.CachedEngineFragmentBuilder()
                .url("check_express")
                .urlParams(map).build();
        getSupportFragmentManager()
                .beginTransaction()
                .replace(R.id.container, boostFragment)
                .commit();
        StatusBarUtil.transparentBottomNavBar(getWindow());
    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "onDestroy: ");
    }
}