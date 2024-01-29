package com.yunda.boosttestandroid;

import android.app.Activity;
import android.graphics.Color;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

public class StatusBarUtil {
    //沉浸式状态栏
    public static void transparentStatusBar(Activity activity) {
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
        activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
        activity.getWindow().setStatusBarColor(Color.TRANSPARENT);
    }

    //状态栏字体颜色黑色或者白色
    public static void setStatusbarWhiteOrBlack(Activity activity, boolean isBlack) {
        if(isBlack) {
            activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                    | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        }
    }

    //设置底部虚拟按键背景
    public static void transparentBottomNavBar(Window window) {
        try {
            window.setNavigationBarColor(Color.WHITE);
        } catch (Exception e) {

        }
    }
}
