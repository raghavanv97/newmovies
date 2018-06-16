package com.vijayaraghavan.newmovies;

import android.annotation.TargetApi;
import android.app.DownloadManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Parcelable;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "vijayaraghavan.com/downloadTorrent";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
                    @Override
                    public void onMethodCall(MethodCall methodCall, Result result) {


                        //this code is to download .torrent file

/*                if(methodCall.method.equals("downloadTorrentFile")){
                  String url = methodCall.argument("url");
//                    final DownloadTask downloadTask = new DownloadTask(this, url);

//                    String url = "url you want to download";
                    DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));
                    request.setDescription("Some descrition");
                    request.setTitle("Some title");
// in order for this if to run, you must use the android 3.2 to compile your app
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                        request.allowScanningByMediaScanner();
                        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
                    }
                    request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, "movies.torrent");

// get download service and enqueue file
                    DownloadManager manager = (DownloadManager) getSystemService(Context.DOWNLOAD_SERVICE);
                    manager.enqueue(request);
                  Toast.makeText(getApplicationContext(), url, Toast.LENGTH_LONG).show();
                }*/


                        //here we are extracting magnet link from json
                        if (methodCall.method.equals("downloadTorrentFile")) {
                            String url = methodCall.argument("url").toString().trim();
                            String movieName = methodCall.argument("Title").toString().trim();
                            System.out.println(url);
                            System.out.println(movieName);
                            Intent i = new Intent(Intent.ACTION_VIEW);
                            i.addCategory(Intent.CATEGORY_BROWSABLE);
                            i.setData(Uri.parse("magnet:?xt=urn:btih:" + url + "&dn=" + movieName +
                                    "&tr=udp://open.demonii.com:1337/announce&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.coppersurfer.tk:6969&tr=udp://glotorrents.pw:6969/announce&tr=udp://tracker.opentrackr.org:1337/announce&tr=udp://torrent.gresille.org:80/announce&tr=udp://p4p.arenabg.com:1337&tr=udp://tracker.leechers-paradise.org:6969"));
                            startActivity(Intent.createChooser(i, "view"));

//                    Intent launchIntent = getPackageManager().getLaunchIntentForPackage("com.delphicoder.flud");
//                    launchIntent.putExtra("url", "magnet:?xt=urn:btih:TORRENT_HASH&dn=Url+Encoded+Movie+Name&tr=http://track.one:1234/announce&tr=udp://track.two:80");
//                    if (launchIntent != null) {
//                        startActivity(launchIntent);//null pointer check in case package name was not found
//                    }
                        }


                    }
                });
    }


}
