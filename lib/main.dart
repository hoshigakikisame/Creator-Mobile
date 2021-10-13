import 'package:creator/creator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // double data = (0.11828 * 0.11926) +
  //     (-0.11926 * -0.11828) +
  //     (-0.17009 * -0.12805) +
  //     (-0.18475 * -0.13196) +
  //     (0.188661 * -0.1349) +
  //     (0.180841 * -0.13001) +
  //     (0.16422 * -0.12317) +
  //     (-0.20039 * -0.13685) +
  //     (-0.16227 * -0.12219) +
  //     (0.173998 * -0.12708) +
  //     (0.194526 * -0.13587) +
  //     (0.163245 * -0.12219) +
  //     (-0.18964 * -0.1349) +
  //     (-0.18573 * -0.13392) +
  //     (-0.18768 * -0.13196) +
  //     (-0.17107 * 0.127077) +
  //     (-0.16325 * 0.123167) +
  //     (0.234604 * -0.15445) +
  //     (-0.16422 * 0.12219) +
  //     (0.174976 * 0.129032) +
  //     (0.182796 * 0.13001) +
  //     (0.159335 * 0.120235) +
  //     (0.173998 * 0.129032) +
  //     (0.175953 * 0.128055) +
  //     (-0.18964 * -0.13392) +
  //     (-0.19159 * -0.1349) +
  //     (-0.18377 * -0.13294) +
  //     (-0.20626 * -0.14174) +
  //     (-0.15836 * -0.12121) +
  //     (-0.16422 * -0.12414) +
  //     (-0.18964 * -0.13587) +
  //     (-0.19355 * -0.13783) +
  //     (-0.21212 * 0.14565) +
  //     (-0.17986 * 0.128055) +
  //     (0.164223 * 0.123167) +
  //     (0.196481 * 0.135875) +
  //     (0.184751 * 0.130987) +
  //     (0.176931 * 0.129032) +
  //     (0.176931 * -0.12903) +
  //     (-0.17498 * -0.12805) +
  //     (-0.16911 * -0.12708) +
  //     (-0.18182 * -0.13001) +
  //     (-0.20039 * -0.13978) +
  //     (-0.15738 * -0.12121) +
  //     (0.189638 * 0.134897) +
  //     (0.177908 * -0.12805) +
  //     (0.195503 * 0.134897) +
  //     (0.168133 * -0.12414) +
  //     (0.175953 * -0.13001) +
  //     (-0.16813 * 0.125122) +
  //     (-0.16618 * 0.123167) +
  //     (-0.18475 * 0.13392) +
  //     (-0.16911 * 0.129032) +
  //     (-0.18671 * 0.138807) +
  //     (-0.17204 * -0.13685) +
  //     (-0.20332 * -0.15934) +
  //     (-0.22581 * -0.18475) +
  //     (0.240469 * -0.21701) +
  //     (0.305963 * -0.2913) +
  //     (0.402737 * -0.40469) +
  //     (0.495601 * -0.52004) +
  //     (0.608016 * 0.652004) +
  //     (0.673509 * 0.73607) +
  //     (0.713587 * 0.780059) +
  //     (-0.71065 * 0.782991) +
  //     (-0.71261 * -0.77028) +
  //     (-0.71945 * -0.76051) +
  //     (-0.70186 * -0.75758) +
  //     (-0.6911 * -0.74096) +
  //     (-0.65787 * -0.70186) +
  //     (-0.63636 * 0.664712) +
  //     (-0.56012 * 0.592375) +
  //     (-0.5347 * -0.54545) +
  //     (0.493646 * -0.49169) +
  //     (-0.45455 * -0.45455) +
  //     (-0.41838 * -0.41056) +
  //     (-0.39785 * -0.38025) +
  //     (-0.36657 * 0.352884) +
  //     (-0.35973 * -0.32747) +
  //     (-0.30499 * 0.281525) +
  //     (-0.28055 * -0.25611) +
  //     (-0.27468 * -0.24145) +
  //     (-0.28837 * -0.23754) +
  //     (-0.27175 * -0.22678) +
  //     (-0.23949 * -0.20039) +
  //     (-0.23265 * -0.19453) +
  //     (-0.21701 * -0.18475) +
  //     (-0.23069 * -0.18475) +
  //     (0.214076 * 0.174976) +
  //     (0.244379 * -0.1828) +
  //     (0.203324 * -0.16325) +
  //     (0.200391 * -0.16031) +
  //     (0.230694 * -0.16716) +
  //     (0.201369 * -0.1564) +
  //     (0.211144 * -0.16031) +
  //     (0.199413 * -0.15152) +
  //     (0.193548 * 0.150538) +
  //     (0.206256 * -0.15152) +
  //     (-0.20235 * 0.151515) +
  //     (-0.1828 * 0.14174) +
  //     (-0.17986 * 0.136852) +
  //     (-0.21017 * 0.152493) +
  //     (-0.19159 * 0.143695) +
  //     (-0.18866 * 0.140762) +
  //     (-0.23167 * 0.16129) +
  //     (-0.22972 * 0.159335) +
  //     (-0.20528 * 0.147605) +
  //     (-0.18866 * 0.142717) +
  //     (-0.18866 * 0.139785) +
  //     (-0.18573 * 0.138807) +
  //     (-0.20235 * -0.14565) +
  //     (0.174976 * -0.13196) +
  //     (0.201369 * -0.14467) +
  //     (0.198436 * -0.14272) +
  //     (0.190616 * -0.13978) +
  //     (0.183773 * -0.13685) +
  //     (0.189638 * -0.13783) +
  //     (0.201369 * -0.1437) +
  //     (0.191593 * -0.13978) +
  //     (0.167155 * -0.12805) +
  //     (0.235582 * 0.159335) +
  //     (0.186706 * 0.136852) +
  //     (-0.1955 * 0.140762) +
  //     (-0.20332 * 0.142717) +
  //     (-0.18182 * 0.132942) +
  //     (-0.16911 * 0.13001) +
  //     (-0.174 * 0.13001) +
  //     (-0.21408 * 0.148583) +
  //     (-0.18768 * 0.136852) +
  //     (-0.17889 * 0.131965) +
  //     (-0.29032 * 0.184751) +
  //     (-0.23558 * 0.15738) +
  //     (-0.18573 * 0.135875) +
  //     (-0.18964 * 0.13783) +
  //     (-0.20137 * 0.143695) +
  //     (-0.19159 * 0.13783) +
  //     (0.207234 * 0.144673) +
  //     (0.186706 * 0.136852) +
  //     (0.168133 * 0.128055) +
  //     (0.208211 * 1.612903) +
  //     (0.198436 * 0.14174) +
  //     (0.200391 * 0.143695) +
  //     (0.172043 * 0.13001) +
  //     (-0.18377 * 0.132942) +
  //     (0.200391 * 0.143695) +
  //     (-0.19257 * 0.139785) +
  //     (0.180841 * 0.134897) +
  //     (-0.21017 * 0.146628) +
  //     (0.184751 * 0.134897) +
  //     (0.180841 * 0.13392) +
  //     (0.292278 * 0.182796) +
  //     (0.192571 * 0.136852) +
  //     (0.214076 * 0.147605) +
  //     (0.189638 * 0.136852) +
  //     (-0.17889 * 0.13392) +
  //     (-0.18671 * 0.134897) +
  //     (-0.1828 * 0.132942) +
  //     (-0.17595 * 0.130987) +
  //     (-0.17791 * 0.129032) +
  //     (-0.21896 * 0.150538) +
  //     (-0.20528 * 0.144673) +
  //     (0.220919 * 0.148583) +
  //     (0.209189 * 0.144673) +
  //     (0.194526 * 0.138807) +
  //     (0.197458 * 0.140762) +
  //     (-0.18573 * 0.13392) +
  //     (0.188661 * 0.134897) +
  //     (0.208211 * 0.147605) +
  //     (0.223851 * 0.154448) +
  //     (-0.18671 * 0.135875) +
  //     (-0.17204 * 0.129032) +
  //     (-0.19159 * 0.13783) +
  //     (-0.19746 * 0.140762) +
  //     (0.191593 * 0.13783) +
  //     (0.190616 * 0.13783) +
  //     (0.185728 * 0.134897) +
  //     (-0.20723 * 0.143695) +
  //     (0.184751 * 0.13392) +
  //     (0.167155 * 0.127077) +
  //     (0.202346 * 0.14174) +
  //     (0.190616 * 0.135875) +
  //     (0.201369 * 0.14174) +
  //     (0.200391 * 0.140762) +
  //     (0.192571 * 0.13783) +
  //     (0.184751 * 0.134897) +
  //     (0.209189 * 0.143695) +
  //     (0.162268 * 0.125122) +
  //     (-0.2219 * 0.150538) +
  //     (0.175953 * 0.129032) +
  //     (0.193548 * 0.138807) +
  //     (0.175953 * 0.13001) +
  //     (0.199413 * 0.139785) +
  //     (0.168133 * 0.125122) +
  //     (-0.18768 * 0.13392) +
  //     (-0.19941 * 0.138807) +
  //     (-0.20821 * 0.14174) +
  //     (-0.18475 * 0.132942) +
  //     (-0.17107 * 0.127077) +
  //     (-0.17791 * 0.13001) +
  //     (-0.21408 * 0.14565) +
  //     (0.171065 * 0.127077) +
  //     (0.202346 * 0.139785) +
  //     (0.16129 * 0.124145) +
  //     (0.167155 * 0.124145) +
  //     (0.180841 * 0.131965) +
  //     (0.191593 * 0.135875) +
  //     (0.205279 * 0.14174) +
  //     (0.185728 * 0.132942) +
  //     (0.180841 * 0.13001) +
  //     (0.193548 * 0.132942) +
  //     (0.189638 * 0.13392) +
  //     (0.201369 * 0.138807) +
  //     (0.196481 * 0.13783) +
  //     (0.192571 * 0.136852) +
  //     (0.198436 * 0.13783) +
  //     (0.210166 * 0.142717) +
  //     (0.190616 * 0.134897) +
  //     (0.191593 * 0.134897) +
  //     (0.182796 * 0.132942) +
  //     (-0.16618 * 0.125122) +
  //     (0.198436 * 0.136852) +
  //     (0.179863 * 0.13001) +
  //     (0.177908 * 0.127077) +
  //     (0.228739 * 0.152493) +
  //     (0.181818 * 0.13001) +
  //     (0.185728 * 0.130987) +
  //     (0.166178 * 0.124145) +
  //     (-0.19453 * 0.135875) +
  //     (-0.16911 * -0.12512) +
  //     (-0.17009 * -0.1261) +
  //     (-0.21799 * -0.14663) +
  //     (-0.19355 * -0.13685) +
  //     (-0.18671 * -0.1349) +
  //     (0.188661 * -0.1349) +
  //     (0.180841 * -0.12903) +
  //     (0.170088 * -0.1261) +
  //     (0.172043 * -0.1261) +
  //     (0.200391 * 0.139785) +
  //     (0.212121 * 0.144673) +
  //     (0.181818 * 0.13001) +
  //     (0.206256 * -0.14174) +
  //     (-0.21017 * -0.14467) +
  //     (0.185728 * -0.13196) +
  //     (-0.19159 * -0.13392) +
  //     (0.176931 * -0.12805) +
  //     (0.188661 * -0.1349) +
  //     (0.195503 * -0.13685) +
  //     (0.166178 * -0.12414) +
  //     (0.186706 * -0.13294) +
  //     (0.214076 * -0.14565) +
  //     (-0.19355 * -0.13783) +
  //     (0.177908 * -0.12805) +
  //     (0.178886 * -0.13001) +
  //     (0.193548 * -0.13783) +
  //     (-0.18866 * -0.13294) +
  //     (0.187683 * 0.13392) +
  //     (0.219941 * 0.14956) +
  //     (-0.18866 * 0.134897) +
  //     (-0.22581 * 0.15347) +
  //     (-0.20332 * 0.139785) +
  //     (-0.17986 * 0.129032) +
  //     (-0.19648 * 0.136852) +
  //     (-0.30499 * 0.183773) +
  //     (-0.21212 * 0.143695) +
  //     (-0.19453 * 0.135875) +
  //     (0.194526 * 0.135875) +
  //     (0.204301 * 0.140762) +
  //     (0.240469 * -0.15738) +
  //     (0.215054 * 0.144673) +
  //     (-0.18573 * 0.132942) +
  //     (0.208211 * -0.14076) +
  //     (0.202346 * 0.14174) +
  //     (-0.20626 * 0.142717) +
  //     (-0.21114 * 0.144673) +
  //     (-0.19062 * 0.13392) +
  //     (-0.19257 * 0.13783) +
  //     (-0.20821 * 0.142717) +
  //     (-0.2131 * -0.14467) +
  //     (0.221896 * 0.152493) +
  //     (-0.20528 * 0.140762) +
  //     (-0.22678 * 0.151515) +
  //     (-0.21799 * 0.146628) +
  //     (-0.19453 * 0.13783) +
  //     (-0.2131 * 0.144673) +
  //     (-0.23949 * 0.155425) +
  //     (-0.20626 * -0.14663) +
  //     (-0.20919 * -0.1437) +
  //     (-0.19941 * -0.13978);
  // print(data);
  runApp(MyApp());
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DatasetProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: 'CREATOR',
          theme: ThemeData(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
          routes: {'/': (context) => MainPage()},
          builder: (context, navigator) {
            final DatasetProvider provider = context.read();

            FlutterBlue.instance.state.listen(
              (event) async {
                if (event == BluetoothState.turningOff) {
                  await provider.disconnectCurrentDevice();
                  provider.connectionState = BluetoothConnState.unknown;
                  showInfoBanner(content: "Bluetooth tidak aktif");
                }
              },
            );

            if (provider.connectedDevice != null)
              provider.connectedDevice!.state.listen((event) async {
                if (event == BluetoothDeviceState.disconnecting) {
                  showInfoBanner(content: "Tidak ada perangkat tersambung");
                  await provider.disconnectCurrentDevice();
                }
              });

            return navigator!;
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
