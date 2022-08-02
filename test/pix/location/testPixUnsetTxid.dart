import 'package:gerencianet/gerencianet.dart';
import 'package:test/test.dart';
import '../../../example/pix/location/pixLocationDeleteTxid.dart';
import '../../../example/pix/charge/pixCreateImmediateCharge.dart';
import '../../../example/gn/key/pixCreateEvp.dart';
import '../../../example/gn/key/pixDeleteEvp.dart';
import '../../credentials.dart';

void main() async {
  Gerencianet gn = Gerencianet(CREDENTIALS_PIX);
  testPixUnsetTxid(gn);
}

dynamic testPixUnsetTxid(Gerencianet gn) async {
  test('pix location delete txid', () async {
    dynamic key = _verifyPixCreateEvp(await pixCreateEvp(gn));
    dynamic charge = _verifyPixCreateImmediateCharge(
        await pixCreateImmediateCharge(gn, key['chave']));
    _verifyPixLocationDelete(
        await pixLocationDeleteTxid(gn, charge['loc']['id']));
    _verifyDixDeleteEvp(await pixDeleteEvp(gn, key['chave']));
  });
}

dynamic _verifyPixLocationDelete(dynamic response) {
  expect(
      response.keys.toList(), equals(['id', 'location', 'tipoCob', 'criacao']));
  return response;
}

dynamic _verifyDixDeleteEvp(dynamic response) {
  expect(response, equals(null));
  return response;
}

dynamic _verifyPixCreateEvp(dynamic response) {
  expect(response.keys.toList(), equals(['chave']));
  return response;
}

dynamic _verifyPixCreateImmediateCharge(dynamic response) {
  expect(
      response.keys.toList(),
      equals([
        'calendario',
        'txid',
        'revisao',
        'loc',
        'location',
        'status',
        'devedor',
        'valor',
        'chave',
        'solicitacaoPagador'
      ]));
  return response;
}
