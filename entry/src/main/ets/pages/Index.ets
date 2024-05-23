import router from '@ohos.router';

@Entry
@Component
struct Index
{
  @State message1: string = '114*******810'
  @State message2: string = '电信提供认证服务'
  @Styles
  imgStyle()
  {
    .width(240)
    .height(120)
  }

  build()
  {
    Row()
    {
      Column()
      {
        Image($r("app.media.frame46")).imgStyle()
          .offset({x:0, y:-40})

        Text(this.message1)
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .fontColor('#ff000000')

        Text(this.message2)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .fontColor('#ff858585')

        Button({ type: ButtonType.Normal, stateEffect: true })
        {
          Text('本机号码一键登录')
            .fontSize(16)
            .fontWeight(FontWeight.Normal)
            .fontColor('#fff6f6f6')
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Normal)
        .margin({top: 20})
        .width('80%')
        .height('6%')
        .borderRadius(8)
        .backgroundColor('#ff000000')
        .onClick(() => {router.pushUrl({url: 'pages/tabs'})})

        Row({space:16})
        {
          Button({ type: ButtonType.Normal, stateEffect: true })
          {
            Text('微信登录')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#ff000000')
              .fontWeight(FontWeight.Bold)
          }
          .type(ButtonType.Normal)
          .margin({top: 20})
          .width('38%')
          .height('6%')
          .borderRadius(8)
          .backgroundColor('#ffb5b5b5')
          .onClick(() => {router.pushUrl({url: 'pages/tabs'})})

          Button({ type: ButtonType.Normal, stateEffect: true })
          {
            Text('Harmony登录')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#ff000000')
              .fontWeight(FontWeight.Bold)
          }
          .type(ButtonType.Normal)
          .margin({top: 20})
          .width('38%')
          .height('6%')
          .borderRadius(8)
          .backgroundColor('#ffb5b5b5')
          .onClick(() => {router.pushUrl({url: 'pages/tabs'})})
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}