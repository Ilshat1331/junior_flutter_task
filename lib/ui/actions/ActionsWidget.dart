// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_test/blocs/actions/ActionsItemQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/resources/api/mall_api_provider.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/actions/item/ActionsItemWidget.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';

class ActionsWidget extends StatefulWidget {
  @override
  _ActionsWidgetState createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends NewBasePageState<ActionsWidget> {
  ActionsHomeQueryBloc bloc;
  int actionId = 1;

  _ActionsWidgetState() {
    bloc = ActionsHomeQueryBloc();
  }

  @override
  Widget build(BuildContext context) {
    if (actionId == -1) {
      final ActionsItemArguments args =
          ModalRoute.of(context).settings.arguments;
      actionId = args.actionId;
    }
    return BlocProvider<ActionsHomeQueryBloc>(
        bloc: bloc, child: getBaseQueryStream(bloc.shopHomeContentStream));
  }

  @override
  Widget onSuccess(RootTypes event, RootResponse response) {
    var actionList = response.serverResponse.body.promo.list;

    print(actionList);
    return _getBody(actionList);
  }

  _getBody(List<PromoItem> actionList) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: actionList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ActionsItemWidget.routeName,
            arguments: ActionsItemArguments(actionList[index].id),
          ),
          child: new Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(140), BlendMode.multiply),
                image: NetworkImage(
                  MallApiProvider.baseImageUrl + actionList[index].imgThumb,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: new Center(
              child: Text(
                actionList[index].name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  void runOnWidgetInit() {
    bloc.loadHomeItemsContent(actionId);
  }
}
