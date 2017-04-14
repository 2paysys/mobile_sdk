package it.twopay.android.appsdk.utility;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.Uri;

import it.twopay.android.appsdk.R;

/**
 * Created by TwoPay Android SDK on 21/01/16.
 */
public class TwoPayUtils {

    /**
     * Check if 2pay App is installed
     * @param ctx
     * @return {@code true} if 2pay App is installed
     */
    public static boolean is2PayAppInstalled(Context ctx) {
        PackageManager pm = ctx.getPackageManager();
        boolean installed = false;
        try {
            pm.getPackageInfo(ctx.getString(R.string.twopay_package), PackageManager.GET_ACTIVITIES);
            installed = true;
        } catch (PackageManager.NameNotFoundException e) {
            installed = false;
        }
        return installed;
    }

    /**
     * Open Play Store 2Pay page
     * @param ctx
     */
    public static void launch2PayStorePage(Context ctx) {
        ctx.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=" + ctx.getString(R.string.twopay_package))));
    }

    /**
     *
     * @return 2Pay version code if installed.
     */
    public static Integer get2PayAppVersionCode(Context ctx) {
        try {
            PackageInfo packageInfo = ctx.getPackageManager().getPackageInfo(ctx.getString(R.string.twopay_package), PackageManager.GET_ACTIVITIES);
            return packageInfo.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            return null;
        }
    }

    /**
     *
     * @return 2Pay version Name if installed.
     */
    public static String get2PayAppVersionName(Context ctx) {
        try {
            PackageInfo packageInfo = ctx.getPackageManager().getPackageInfo(ctx.getString(R.string.twopay_package), PackageManager.GET_ACTIVITIES);
            return packageInfo.versionName;
        } catch (PackageManager.NameNotFoundException e) {
            return null;
        }
    }
}
