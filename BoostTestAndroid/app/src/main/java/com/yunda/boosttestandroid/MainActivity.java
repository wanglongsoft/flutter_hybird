package com.yunda.boosttestandroid;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import androidx.appcompat.app.AppCompatActivity;
import com.idlefish.flutterboost.EventListener;
import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.ListenerRemover;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "MyApp";
    private View pendSettleAmountClick;
    private View settleAmountClick;
    private View walletItemViewClick;
    FlutterBoostRouteOptions options;
    FlutterBoostRouteOptions brunoOptions;
    EventListener listener;
    ListenerRemover remover;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d(TAG, "onCreate: ");
        StatusBarUtil.transparentStatusBar(this);
        StatusBarUtil.setStatusbarWhiteOrBlack(this, true);
        StatusBarUtil.transparentBottomNavBar(getWindow());
        setContentView(R.layout.activity_main);
        listener = (key, args) -> {
            Log.d(TAG, "eventToNative: " + args.toString());
            //deal with your event here
            Map<String,Object> map = new HashMap<>();
            map.put("data","receive flutter message");
            FlutterBoost.instance().sendEventToFlutter("eventToFlutter", map);
        };
        remover = FlutterBoost.instance().addEventListener("eventToNative", listener);
        options = new FlutterBoostRouteOptions.Builder()
                .pageName("check_express")
                .arguments(new HashMap<>())//可以传递入参
                .build();
        brunoOptions = new FlutterBoostRouteOptions.Builder()
                .pageName("bruno_component")
                .arguments(new HashMap<>())//可以传递入参
                .build();

        walletItemViewClick = findViewById(R.id.wallet_view_click);
        walletItemViewClick.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this,
                        FlutterFragmentActivity.class);
                startActivity(intent);
            }
        });

        settleAmountClick = findViewById(R.id.settle_amount_click);
        settleAmountClick.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                FlutterBoost.instance().open(options);
            }
        });

        pendSettleAmountClick = findViewById(R.id.pend_settle_amount_click);
        pendSettleAmountClick.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                FlutterBoost.instance().open(brunoOptions);
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "onDestroy: ");
        remover.remove();
    }
}