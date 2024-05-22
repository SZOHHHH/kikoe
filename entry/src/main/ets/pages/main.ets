import { DrawerLayout } from '@smarthane/drawer-layout'
import router from '@ohos.router';

@Component
export struct main {
  @Styles
  ImgStyle1()
  {
    .width(32)
    .height(32)
  }
  @Styles
  ImgStyle2()
  {
    .width(42)
    .height(42)
    .borderRadius(24)
  }
  @State message1: string = 'Hi，欢迎回来'
  @State model: DrawerLayout.Model = new DrawerLayout.Model()
    .setDrawerType(DrawerLayout.Type.LEFT)
    .setDrawerWidth(280);
  private listScroller;

  onBackPress()
  {
    if (this.model.isDrawerOpen) {
      this.model.closeDrawer();
      return true;
    }
    return false;
  }

  build()
  {
    Column()
    {
      Column({space: 16})
      {
        Row()
        {
          DrawerLayout({
            model: $model,
            drawerView: () => {
              this.buildDrawerView();
            },
            contentView: () => {
              this.buildContentView();
            }
          })
        }
      }.width('100%').height('92%').justifyContent(FlexAlign.Start)
    }
  }

  @Builder buildContentView()
  {
    Column({space: 16})
    {
      Row()
      {
        Image("/assets/background.jpg").ImgStyle2()
          .onClick(() => {this.model.openOrCloseDrawer();})
        Text(this.message1)
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .textAlign(TextAlign.Center)
          .fontColor('#ff000000')
          .offset({ x: 20, y: 4 })
      }
      .offset({x:-64, y:0})

      Button({ type: ButtonType.Normal, stateEffect: true })
      {
        Row() {}
        .width('100%')
        .height('100%')
        .backgroundImage('assets/daoru.png')
        .backgroundImageSize(ImageSize.Cover)
        .backgroundImagePosition(Alignment.Center)
      }
      .borderRadius(20)
      .width(320)
      .height(200)
      .border({ width:'8px', color:'#ffb5b5b5' })
      .onClick(() => {router.pushUrl({url: 'pages/musicdetail'})})
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }

  @Builder buildDrawerView() {
    Column() {
      // @ts-ignore
      if (this.model.drawerType == DrawerLayout.Type.LEFT) {
        Text('这是左边抽屉项\n1.可左右滑动\n2.点击遮罩层关闭')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      } else {
        Text('这是右边抽屉项\n1.可左右滑动\n2.点击遮罩层关闭')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
    }
    .backgroundColor(Color.Orange)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}function ImageMapView() {
throw new Error('Function not implemented.')
}
