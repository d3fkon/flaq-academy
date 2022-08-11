import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class FlaqEvents {
  // AUTH
  static const loggedIn = 'logged_in';
  static const loggedOut = 'logged_out';

  // PARTICIPATION SCREEN
  static const inParticipationScreen = 'in_participation_screen';
  static const clickedOnActiveCampaign = 'clicked_on_active_campaign';
  static const clickedOnFinishedCampaign = 'clicked_on_finished_campaign';

  // Explore Screen
  static const inExploreScren = 'in_explore_screen';
  static const clickedOnBannerExploreCard = 'clicked_on_banner_explore_card';
  static const clickedOnExploreCard = 'clicked_on_explore_card';

  // Campaign Detail Screen
  static const inCampaignDetailScreen = 'in_campaign_detail_screen';
  static const clickedOnVideoPlayButton = 'clicked_on_video_play_button';
  static const clickedOnVideoPauseButton = 'clicked_on_video_pause_button';
  static const clickedOnVideoFullScreen = 'clicked_on_video_full_screen';
  static const clickedOnVideoExitFullScreen =
      'clicked_on_video_exit_full_screen';
  static const swipedOnParticipate = 'swiped_on_participate';
}

const _mixpanelToken = "98e8f9d26f3e5ef88fa09c3f3c145d18";

class TrackingService extends GetxService {
  late final Mixpanel _mixpanel;

  Future<TrackingService> init() async {
    _mixpanel =
        await Mixpanel.init(_mixpanelToken, optOutTrackingDefault: false);
    return this;
  }

  // Track an event
  void track(String eventName, {Map<String, dynamic>? properties}) {
    _mixpanel.track(eventName, properties: properties);
  }
}
