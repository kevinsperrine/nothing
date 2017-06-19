/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';

// Add a reference to our native module
import AWSMobileHub from './AWSMobileHub'

import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

export default class Woodstock extends Component {

	constructor(props) {

		super(props);

		// Configure the native module. These values can be
    // the same / copied from the com.amazonaws.mobile.AWSConfiguration
    // they can then be changed from here.
		AWSMobileHub.initializeApplication(
			// Cognito ID Pool
			'us-east-1:18f7a706-f16c-45fa-a1c4-790b2c93ddd1',
			// Pinpoint (previously Mobile Analytics) Application ID
			'4dca8c0e8d98417e8606a657c610ba98',
			// GCM Sender ID
			'908475700363',
			// AWS Region
			'us-east-1'
		)
	}

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.android.js
        </Text>
        <Text style={styles.instructions}>
          Double tap R on your keyboard to reload,{'\n'}
          Shake or press menu button for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('Woodstock', () => Woodstock);
