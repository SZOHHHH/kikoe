import router from '@ohos.router';
import { StyleConstants } from '../common/constants/StyleConstants';
import { BreakpointType } from '../common/utils/BreakpointSystem';
import { SongItem } from '../viewmodel/SongData';
import { MusicList } from '../viewmodel/MusicListViewModel';

import { ControlComponent } from '../components/ControlComponent';
import { LyricsComponent } from '../components/LyricsComponent';
import { MusicInfoComponent } from '../components/MusicInfoComponent';
import { PlayConstants } from '../common/constants/PlayConstants';

@Entry
@Component
struct PlayPage {
  @State currentTabIndex: number = 0;
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  songList: SongItem[] = MusicList;
  @StorageProp('selectIndex') selectIndex: number = 0;

  build()
  {
    Stack({ alignContent: Alignment.TopStart })
    {
      if (this.currentBreakpoint === PlayConstants.LG)
      {
        Stack({ alignContent: Alignment.Top })
        {
          LyricsComponent()

          Flex({ direction: FlexDirection.Column })
          {
            MusicInfoComponent()
            ControlComponent()
          }
        }
      } else
      {
        Flex({ direction: FlexDirection.Column })
        {
          Tabs({ barPosition: BarPosition.Start, index: this.currentTabIndex })
          {
            TabContent()
            {
              MusicInfoComponent()
            }
            .tabBar(this.TabTitle(PlayConstants.TAB_SONG, 0))

            TabContent()
            {
              LyricsComponent()
            }
            .tabBar(this.TabTitle(PlayConstants.TAB_LYRICS, 1))
          }
          .onChange(index => this.currentTabIndex = index)
          .vertical(false)
          .barHeight($r('app.float.fifty_six'))
          .barWidth(PlayConstants.TAB_WIDTH)

          ControlComponent()
        }
      }

      Image($r('app.media.ic_back_down'))
        .width($r('app.float.image_back_size'))
        .height($r('app.float.image_back_size'))
        .margin({ left: $r('app.float.twenty_four'), top: $r('app.float.image_back_margin_top') })
        .onClick(() => router.back())
    }
    .backgroundImage(this.songList[this.selectIndex].label)
    .backgroundImageSize(ImageSize.Cover)
    .backdropBlur(PlayConstants.BLUR)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [PlayConstants.EIGHTY_WHITE_COLOR, PlayConstants.EIGHTY_WHITE],
        [PlayConstants.NINETY_WHITE_COLOR, PlayConstants.NINETY_WHITE]
      ]
    })
    .height(StyleConstants.FULL_HEIGHT)
    .width(StyleConstants.FULL_WIDTH)
  }

  @Builder
  TabTitle(title: string | Resource, index: number) {
    Text(title)
      .fontColor(this.currentTabIndex === index ? $r('app.color.text_color') : $r('app.color.text_forty_color'))
      .fontWeight(this.currentTabIndex === index ? PlayConstants.FIVE_HUNDRED : PlayConstants.FOUR_HUNDRED)
      .fontSize(new BreakpointType({
        sm: $r('app.float.font_sixteen'),
        md: $r('app.float.font_twenty')
      }).getValue(this.currentBreakpoint))
      .border({
        width: { bottom: this.currentTabIndex === index ? $r('app.float.tab_border_width') : 0 },
        color: $r('app.color.text_color')
      })
      .padding({ bottom: $r('app.float.tab_text_padding_bottom') })
  }

  pageTransition() {
    PageTransitionEnter({ duration: PlayConstants.FIVE_HUNDRED, curve: Curve.Smooth }).slide(SlideEffect.Bottom);
    PageTransitionExit({ duration: PlayConstants.FIVE_HUNDRED, curve: Curve.Smooth }).slide(SlideEffect.Bottom);
  }
}