import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../di/locator.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookID;
  const BookDetailScreen({
    Key? key,
    required this.bookID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildColumn(),
    );
  }

  Widget _buildColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopContainer(),
          _buildBottomContainer(),
        ],
      );

  Widget _buildTopContainer() => Expanded(
        flex: 1,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://static.remove.bg/remove-bg-web/3661dd45c31a4ff23941855a7e4cedbbf6973643/assets/start_remove-79a4598a05a77ca999df1dcb434160994b6fde2c3e9101984fb1be0f16d0a74e.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: IconButton(
            alignment: Alignment.bottomRight,
            color: Colors.red,
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            iconSize: 60,
          ),
        ),
      );

  Widget _buildBottomContainer() => Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Author',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Text('4.5'),
                  ],
                ),
                Text('About'),
                Text(
                    'Curae vitae purus efficitur potenti libero mi vestibulum montes gravida integer venenatis, mattis dictumst ad lorem lobortis congue etiam rutrum justo bibendum magnis, proin consectetur accumsan sagittis quam morbi ullamcorper rhoncus placerat turpis. Eleifend dolor quis dictumst vivamus lacinia vel condimentum efficitur aptent, fringilla semper adipiscing ante purus cras aliquet velit quam, dictum porttitor proin nisl tristique viverra felis nec. Viverra dictum tortor tristique ornare ridiculus mollis varius vulputate erat adipiscing nullam, vel ligula leo quam fames nam integer tempus egestas. Cras lacus per fusce eleifend egestas dolor etiam massa posuere ad, faucibus vitae leo tristique hac phasellus laoreet tempus vivamus sapien, velit nulla mollis enim finibus aliquet donec eu varius. Eleifend ipsum id nisl est netus primis penatibus rutrum, tortor purus ex finibus libero bibendum cursus, erat risus vestibulum tincidunt iaculis senectus fringilla. Congue eu cubilia aptent ipsum montes tortor aliquam volutpat accumsan, nam ridiculus nula aptent lacus nisl nulla per duis. Sollicitudin fringilla senectus potenti ut quis vel condimentum bibendum maximus, platea habitant sagittis elementum eu nec euismod rutrum porttitor tristique, mi tempus cursus mattis sapien dictum facilisis fusce. Vitae eget habitasse est aptent dictum lobortis senectus, iaculis placerat erat hendrerit duis elementum, quam pellentesque suspendisse ad morbi ex.'),
              ],
            ),
          ),
        ),
      );
}
