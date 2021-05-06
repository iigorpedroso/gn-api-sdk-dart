import 'package:gerencianet/gerencianet.dart';
import '../../credentials.dart';

void main() async {
  credentials.remove('pix_cert');
  credentials.remove('pix_private_key');
  Gerencianet gn = Gerencianet(credentials);
  dynamic response = await payCharge(gn, 0);
  print(response);
}

dynamic payCharge(Gerencianet gn, int chargeId) async {
  dynamic payment = {
    "payment": {
      "banking_billet": {
        "expire_at": "2021-12-12",
        "customer": {
          "name": "Gorbadoc Oldbuck",
          "email": "oldbuck@gerencianet.com.br",
          "cpf": "04267484171",
          "birth": "1977-01-15",
          "phone_number": "5144916523"
        }
      }
    }
  };

  return await gn.call("payCharge", params: {"id": chargeId}, body: payment);
}
