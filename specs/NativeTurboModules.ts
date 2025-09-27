import { TurboModule, TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  sendMessage(message: string): void;
  getMessage(): Promise<string>;
  sendWithCallback(callback: (response: string) => void): void;

  addListener(eventName: string): void;
  removeListeners(count: number): void;
  startSendingEvents(): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('NativeTurboModules');
