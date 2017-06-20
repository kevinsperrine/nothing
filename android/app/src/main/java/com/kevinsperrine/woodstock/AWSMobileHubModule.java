/*
* Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
* Licensed under the Amazon Software License (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*   http://aws.amazon.com/asl/
*
* or in the "license" file accompanying this file. This file is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or implied.
* See the License for the specific language governing permissions and limitations
* under the License.
*/
package com.kevinsperrine.woodstock;

import com.amazonaws.mobile.AWSMobileClient;
import com.amazonaws.mobile.AWSConfiguration;
import com.amazonaws.regions.Regions;
import com.amazonaws.mobileconnectors.pinpoint.analytics.AnalyticsClient;
import com.amazonaws.mobileconnectors.pinpoint.analytics.AnalyticsEvent;
import com.amazonaws.mobileconnectors.pinpoint.analytics.monetization.GooglePlayMonetizationEventBuilder;
import com.amazonaws.http.HttpMethodName;
import com.amazonaws.util.IOUtils;
import com.amazonaws.util.StringUtils;

import android.net.UrlQuerySanitizer;
import android.os.Bundle;
import android.util.Log;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Arrays;

import org.json.JSONObject;

public class AWSMobileHubModule extends ReactContextBaseJavaModule implements LifecycleEventListener {

	private final static String LOG_TAG = AWSMobileHubModule.class.getSimpleName();

  private ReactApplicationContext context;
  private static boolean inForeground = true;

  public AWSMobileHubModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.context = reactContext;
    reactContext.addLifecycleEventListener(this);
  }

  @Override
  public String getName() {
    return "AWSMobileHub";
  }

  public static boolean isInForeground() {
    return inForeground;
  }

  private Map<String,String> convertQueryStringToParameters(String queryStringText) {

    while (queryStringText.startsWith("?") && queryStringText.length() > 1) {
        queryStringText = queryStringText.substring(1);
    }

    final UrlQuerySanitizer sanitizer = new UrlQuerySanitizer();
    sanitizer.setAllowUnregisteredParamaters(true);
    sanitizer.parseQuery(queryStringText);

    final List<UrlQuerySanitizer.ParameterValuePair> pairList = sanitizer.getParameterList();
    final Map<String, String> parameters = new HashMap<>();

    for (final UrlQuerySanitizer.ParameterValuePair pair : pairList) {
        Log.d(LOG_TAG, pair.mParameter + " = " + pair.mValue);
        parameters.put(pair.mParameter, pair.mValue);
    }

    return parameters;
}

  /**
   * Submit a pause session event to AWS Mobile Analytics
   * @param {CallbackContext}
   */
  @Override
  public void onHostPause() {
    inForeground = false;
  }

  /**
  * Submit a resume session event to AWS Mobile Analytics
  * @param {CallbackContext}
  */
  @Override
  public void onHostResume() {
    inForeground = true;
  }

  @Override
  public void onHostDestroy() {
    inForeground = false;
  }

  /**
  * Initialize the plugin with AWS Cognito and credential ID
  * from AWS Mobile Analytics
  * @param {String} Cognito Pool ID
  * @param {String} Mobile Analytics App ID
  * @param {String} GCM sender ID
  * @param {String} AWS Region
  */
  @ReactMethod
  public void initializeApplication(
    String poolId,
    String appId,
    String senderId,
    String region
  ) {
    AWSConfiguration.AMAZON_COGNITO_IDENTITY_POOL_ID = poolId;
    AWSConfiguration.AMAZON_MOBILE_ANALYTICS_APP_ID = appId;
    AWSConfiguration.GOOGLE_CLOUD_MESSAGING_SENDER_ID = senderId;
    AWSConfiguration.AMAZON_COGNITO_REGION = Regions.fromName(region);
    AWSConfiguration.AMAZON_MOBILE_ANALYTICS_REGION = Regions.fromName(region);
    AWSMobileClient.initializeMobileClientIfNecessary(this.context);
  }

  /**
   * Update dartboard custom attributes
   * @param {String} attribute name i.e. Interest
   * @param {String} comma delimited list of values i.e. "Compute,Database,Mobile"
   */
  @ReactMethod
  public void updateAttributes(String attr, String values) {
    AWSMobileClient
        .defaultMobileClient()
        .getPinpointManager()
        .getTargetingClient()
        .addAttribute(attr, Arrays.asList(values.split(",")));
    AWSMobileClient
        .defaultMobileClient()
        .getPinpointManager()
        .getTargetingClient()
        .updateEndpointProfile();
  }
}
