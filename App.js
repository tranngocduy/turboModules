import React, { useEffect } from 'react';
import { View, Button, NativeEventEmitter } from 'react-native';

import NativeTurboModules from './specs/NativeTurboModules';

const eventEmitter = new NativeEventEmitter(NativeTurboModules);

const App = () => {

  const _onGetMessage = async () => {
    const message = await NativeTurboModules.getMessage();
    console.log('_onGetMessage', message)
  }

  const _onSendMessage = () => {
    NativeTurboModules.sendMessage('_onSendMessage')
  }

  const _onSendMessageWithCallback = () => {
    NativeTurboModules.sendWithCallback(message => {
      console.log('_onSendMessageWithCallback', message)
    })
  }

  const _onStartListening = () => {
    NativeTurboModules.startSendingEvents();
  };

  useEffect(() => {
    const subscription = eventEmitter.addListener('EventReminder', event => {
      console.log('Event received:', event.message);
    });

    return () => subscription?.remove();
  }, []);

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>

      <Button title='getMessage' onPress={_onGetMessage} />
      <Button title='startListening' onPress={_onStartListening} />

      <Button title='sendMessage' onPress={_onSendMessage} />
      <Button title='sendMessageWithCallback' onPress={_onSendMessageWithCallback} />

    </View>
  )

}

export default App;
