import 'dart:io';

import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/data/models/article.dart';
import 'package:dicoding_news_app/provider/database_provider.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/provider/preferences_provider.dart';
import 'package:dicoding_news_app/provider/scheduling_provider.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';
import 'package:dicoding_news_app/utils/results_state.dart';
import 'package:dicoding_news_app/widgets/card_article.dart';
import 'package:dicoding_news_app/widgets/custom_dialog.dart';
import 'package:dicoding_news_app/widgets/custom_scaffold.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'home_page.dart';
part 'article_list_page.dart';
part 'article_detail_page.dart';
part 'article_webview_page.dart';
part 'settings_page.dart';
part 'bookmarks_page.dart';