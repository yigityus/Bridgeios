/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Button,
  NativeModules,
  NativeEventEmitter,
  ScrollView
} from 'react-native';

const { DynamoManager } = NativeModules;

const dynamoManagerEmitter = new NativeEventEmitter(DynamoManager);

export default class Bridgeios extends Component {


  subscriptionDeviceConnectionDidChange = dynamoManagerEmitter.addListener(
      'DeviceConnectionDidChange',
      (data) => {
        this.onEventChange(data);
      }
  );


  subscriptionDataReceived = dynamoManagerEmitter.addListener(
      'DataReceived',
      (data) => {
        this.onEventChange(data);
      }
  );



  subscriptionDataReceived = dynamoManagerEmitter.addListener(
      'CardSwipeDidStart',
      (data) => {
        this.onEventChange(data);
      }
  );



  subscriptionDataReceived = dynamoManagerEmitter.addListener(
      'CardSwipeDidGetTransError',
      (data) => {
        this.onEventChange(data);
      }
  );

  constructor() {
    super();


    this.state = {
      logs: 'App started..',
    }

    this.onEventChange = this.onEventChange.bind(this);

  }

  componentWillUnmount() {

    subscriptionDataReceived.remove();
    subscriptionCardSwipeDidStart.remove();
    subscriptionCardSwipeDidGetTransError.remove();
    subscriptionDeviceConnectionDidChange.remove();
  }

  render() {
    return (
      <View style={styles.container}>

        <Button title="isDeviceOpened"  onPress= { () => this.isDeviceOpened() }/>
        <Button title="isDeviceConnected"  onPress= { () => this.isDeviceConnected() }/>
        <Button title="openDevice"  onPress= { () => this.openDevice() }/>
        <Button title="closeDevice"  onPress= { () => this.closeDevice() }/>

        <ScrollView contentContainerStyle={{justifyContent: 'flex-start', }} style={{flex: 1, alignSelf: 'stretch', margin: 30, }}>
          <Text style={styles.instructions}>{this.state.logs}</Text>
        </ScrollView>


      </View>
    );
  }


  addEvent() {
    CalendarManager.addEvent('Birthday Party', '4 Privet Drive, Surrey');
  }

  openDevice() {
    DynamoManager.openDevice();
  }

  closeDevice() {
    DynamoManager.closeDevice();
  }

  isDeviceOpened() {
    DynamoManager.isDeviceOpened((err, opened) => {
      if(err) {
        console.error(err);
      } else {
        console.log('isDeviceOpened: ', opened);
        let logs = this.state.logs.concat('\nisDeviceOpened: ', opened)
        this.setState({logs});
      }
    })
  }

  isDeviceConnected() {
    DynamoManager.isDeviceConnected((err, connected) => {
      if(err) {
        console.error(err);
      } else {
        console.log('isDeviceConnected: ', connected);
        let logs = this.state.logs.concat('\nisDeviceConnected: ', connected)
        this.setState({logs});
      }
    })
  }

  onEventChange(data) {
    let logs = this.state.logs.concat('\ndata: ', JSON.stringify(data))
    this.setState({logs});
  }

}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    margin: 40,
    alignItems: 'center',
    justifyContent: 'flex-start',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'left',
    color: '#333333',
    marginBottom: 5,
    flex: 1,
  },
});

AppRegistry.registerComponent('Bridgeios', () => Bridgeios);
