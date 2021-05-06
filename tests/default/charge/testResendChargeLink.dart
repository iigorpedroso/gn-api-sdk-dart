import 'package:gerencianet/gerencianet.dart';
import 'package:test/test.dart';
import '../../../examples/default/charge/createCharge.dart';
import '../../../examples/default/charge/linkCharge.dart';
import '../../../examples/default/charge/resendChargeLink.dart';
import '../../credentials.dart';

void main() async {
  Gerencianet gn = Gerencianet(CREDENTIALS_DEFAULT);
  testResendChargeLink(gn);
}

dynamic testResendChargeLink(Gerencianet gn) async {
  test('charge resend link', () async {
    dynamic charge = _verifyCreateCharge(await createCharge(gn));
    _verifyCreateChargeLink(await linkCharge(gn, charge['data']['charge_id']));
    _verifyResendChargeLink(
        await resendChargeLink(gn, charge['data']['charge_id']));
  });
}

void _verifyResendChargeLink(dynamic response) {
  expect(response.keys.toList(), equals(['code']));
  expect(response['code'], equals(200));
  return response;
}

void _verifyCreateChargeLink(dynamic response) {
  expect(response.keys.toList(), equals(['code', 'data']));
  expect(response['code'], equals(200));
  expect(
      response['data'].keys.toList(),
      equals([
        'charge_id',
        'status',
        'total',
        'custom_id',
        'payment_url',
        'payment_method',
        'billet_discount',
        'card_discount',
        'conditional_discount_date',
        'request_delivery_address',
        'message',
        'expire_at',
        'created_at'
      ]));
  return response;
}

dynamic _verifyCreateCharge(dynamic response) {
  expect(response.keys.toList(), equals(['code', 'data']));
  expect(response['code'], equals(200));
  expect(
      response['data'].keys.toList(),
      equals([
        'charge_id',
        'status',
        'total',
        'custom_id',
        'created_at',
      ]));
  return response;
}
