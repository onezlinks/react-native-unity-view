import React from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle,
  Platform,
  NativeSyntheticEvent,
} from 'react-native';

interface UnityMessage {
  message: string;
}

type UnityPlayTsProps = {
  onUnityMessage?: (event: NativeSyntheticEvent<UnityMessage>) => void;
};

const ComponentName = 'UnityPlayTsView';

const UnityPlayTsView = requireNativeComponent<UnityPlayTsProps>(ComponentName);

export default class UnityPlayView extends React.Component<UnityPlayTsProps> {
  static defaultProps = {};

  constructor(props: any) {
    super(props);
  }

  public postMessage(gameObject: string, methodName: string, message: string) {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this),
      this.getCommand('postMessage'),
      [gameObject, methodName, message]
    );
  }

  private getCommand(cmd: string): any {
    if (Platform.OS === 'ios') {
      return UIManager.getViewManagerConfig('UnityPlayTsView').Commands[cmd];
    } else {
      return cmd;
    }
  }

  private getProps() {
    return {
      ...this.props,
    };
  }

  public render() {
    return <UnityPlayTsView {...this.getProps()} />;
  }
}
