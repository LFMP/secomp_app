import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Bloc
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/models/authorization.dart';
// Utils
import 'package:pet_app/utils/slider.dart';
import 'package:pet_app/utils/snack_bar.dart';
// Widgets
import 'package:pet_app/widgets/commons/loading_widget.dart';

class LoginPage extends StatelessWidget {

  final _userController = TextEditingController();
  final _passController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {

    final _authBloc = BlocProvider.of<AuthBloc>(context);

    void _sendLogin() => _authBloc.dispatch(
      AuthLogin(
        request: AuthRequest(
          username: _userController.text,
          password: _passController.text
        )
      )
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        
        if (state is AuthUnauthenticated) {
          SimpleSnackBar.showSnackBar(
            context,
            state.message
          );
        }

        if (state is AuthAuthenticated) {
          SimpleSnackBar.showSnackBar(
            context,
            state.response.token,
            color: Colors.green
          );
          // Navigator.of(context).pushAndRemoveUntil(
          //     SlideRoute(
          //         page: BlocProvider<PerfilBloc>(
          //           builder: (context) => BlocProvider.of<PerfilBloc>(context),
          //           child: PerfilPage(),
          //         ),
          //         direction: SlideDirection.BOTTOM_TOP),
          //     (_) => false);
        }
      },
      child: BlocBuilder(
        bloc: _authBloc,
        builder: (context, state){
           
          final _child = state is AuthLoading ? LoadingWidget()
          : Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(60),),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/lambda_transparent.png"),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: () => _sendLogin()
                )
              ),
            );

          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 60, left: 40, right: 40),
              color: Colors.blue,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    width: 128,
                    height: 128,
                    child: Image.asset("assets/logoPetBranco.png"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    // autofocus: true,
                    controller: _userController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail ou username",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // autofocus: true,
                    controller: _passController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _child,
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          );
        }
      )
    );
  }
}