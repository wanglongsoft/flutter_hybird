package com.yunda.boosttestandroid;

import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;

import androidx.appcompat.widget.AppCompatTextView;

public class MarqueeTextView extends AppCompatTextView {

    private Runnable mDelayMarquee;
    public MarqueeTextView(Context context) {
        super(context);
        initDelayMarquee();
    }

    public MarqueeTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initDelayMarquee();
    }

    public MarqueeTextView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initDelayMarquee();
    }

    @Override
    public boolean isFocused() {
        return true;
    }

    private void initDelayMarquee() {
        mDelayMarquee = new Runnable() {
            @Override
            public void run() {
                setEllipsize(TextUtils.TruncateAt.MARQUEE);
            }
        };
    }

    public void delayStartMarquee() {
        setEllipsize(TextUtils.TruncateAt.END);
        if(null != getHandler()) {
            getHandler().postDelayed(mDelayMarquee, 1000);
        }
    }

    @Override
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        if(null != getHandler()) {
            getHandler().removeCallbacks(mDelayMarquee);
        }
    }
}
