import 'react-native';
import React from 'react';
import Index from '../index.android.js';
import {
  NativeModules,
} from 'react-native';

// Note: test renderer must be required after react-native.
import renderer from 'react-test-renderer';

jest.mock('../AWSMobileHub', () => {
  return {
    initializeApplication: jest.fn()
  };
});

it('renders correctly', () => {
  const tree = renderer.create(
    <Index />
  );
});
