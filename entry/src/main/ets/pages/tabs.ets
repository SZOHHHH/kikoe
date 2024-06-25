import {main} from './main'
import {list} from './list'
import {community} from './community1'
import {config} from './config1'

@Entry
@Component
struct Index
{
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column()
    {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width(30)
        .height(30)
      Text(title)
        .fontColor(this.currentIndex === index ? '#077afb': '#d4d2d6')
        .fontSize(12)
    }
    .onClick(() =>
    {
      this.currentIndex = index;
      this.tabsController.changeIndex(index);
    })
  }

  build()
  {
    Tabs({barPosition: BarPosition.End, controller: this.tabsController})
    {
      TabContent()
      {
        main()
      }.tabBar(this.TabBuilder('主页', 0, $r('app.media.categorypur'), $r('app.media.category')))

      TabContent()
      {
        community()
      }.tabBar(this.TabBuilder('社区', 1, $r('app.media.circle_morepur'), $r('app.media.circle_more')))

      TabContent()
      {
        list()
      }.tabBar(this.TabBuilder('曲库', 2, $r('app.media.copypur'), $r('app.media.copy')))

      TabContent()
      {
        config()
      }.tabBar(this.TabBuilder('个人', 3, $r('app.media.userpur'), $r('app.media.user')))
    }
    .barWidth('100%')
    .barHeight(60)
    .barMode(BarMode.Fixed)
    .onChange((index: number) =>
    {
      this.currentIndex = index
    })
  }
}