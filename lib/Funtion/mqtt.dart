import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

const String url = 'broker-cn.emqx.io';        //主机位置
const int port = 1883;              //MQTT端口
const clientID = 'Client01';    //Mqtt客户端ID
const username = 'Client01';    //Mqtt username
const password = 'password';    //Mqtt password

final client = MqttServerClient.withPort(url, clientID, port);

Future<void> connect() async {
  client.port = port;
  client.setProtocolV311();
  client.logging(on: true);

  await client.connect(username, password);

  if (client.connectionStatus?.state == MqttConnectionState.connected) {
    print('client connected');
    client.subscribe("/home/test", MqttQos.atLeastOnce);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttMessage message = c[0].payload;
      if (message is MqttPublishMessage) {
        final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print('${c[0].topic}:$payload');
      }
    });
  } else {
    print(
        'ERROR client connection failed - disconnecting, state is ${client.connectionStatus?.state}');
    client.disconnect();
  }
}

void sendMessage(String topic, String message) {
  final builder = MqttClientPayloadBuilder();
  builder.addString(message);
  client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
}
