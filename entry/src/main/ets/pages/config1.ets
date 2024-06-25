//import { spread } from '@ohos/axios'
@Component
export struct config {
  @Styles
  ImgStyle1()
  {
    .width(32)
    .height(32)
  }

  build()
  {
    Column({space:10})
    {
      Column() {
        Image('/assets/ao.jpg')
      }
      .height(150)
      .width('100%')

      Column()
      {
       Row({space:30})
       {
         Row({space:10}) {
           Image('/assets/ao2.jpg').width(60).height(60).borderRadius(10)
           Column() {
             Text('青叶市子').fontSize(24).fontWeight(1000).fontColor(Color.Black)
             Text('Ichiko Aoba').fontSize(16).fontWeight(500).fontColor(Color.Grey)
           }
         }
         Text('原声吉他手、实验音乐家').fontSize(12).fontColor('#ff0d7a7a').fontWeight(500)
       }.width('95%').alignItems(VerticalAlign.Bottom)
      }
      .padding({bottom:10,top:10})
      .width('95%')
      .backgroundColor('#ffffffff')
      .borderRadius(10)

      Column()
      {
        List() {
          ListItem() {
            Row() {
              Row() {
                Image('/assets/output.svg')
                  .width(30)
                  .height(30)
                  .margin(10)
                Text('发布新作品').fontSize(20).fontColor('#000000')
              }
              .layoutWeight(1)
              Image('/assets/right.svg')
                .width(30)
                .height(30)
                .margin(10)
            }
          }
          .height(60)

          ListItem() {
            Row() {
              Row() {
                Image($r('app.media.ic_music_icon'))
                  .width(30)
                  .height(30)
                  .margin(10)
                Text('分享的作品').fontSize(20).fontColor('#000000')
              }
              .layoutWeight(1)
              Text('51').fontSize(20).fontColor('#333').margin(10)
            }
          }
          .height(60)

          ListItem() {
            Row() {
              Row() {
                Image($r('app.media.tool_like'))
                  .width(30)
                  .height(30)
                  .margin(10)
                Text('收获的喜爱').fontSize(20).fontColor('#000000')
              }
              .layoutWeight(1)
              Text('999+').fontSize(20).fontColor('#ffff0000').margin(10)
            }
          }
          .height(60)

          ListItem() {
            Row() {
              Row() {
                Image($r('app.media.tool_comment'))
                  .width(30)
                  .height(30)
                  .margin(10)
                Text('收到的消息').fontSize(20).fontColor('#000000')
              }
              .layoutWeight(1)
              Text('999+').fontSize(20).fontColor('#ffff0000').margin(10)
            }
          }
          .height(60)
        }
        .padding(5)
        .divider({
          strokeWidth: 1,
          startMargin: 60,
          endMargin: 10,
          color: '#ffdbdbdb'
        })
        .backgroundColor(Color.White)
      }
      .width('95%')
      .padding(5)
      .borderRadius(10)

        Column()
        {
          List()
          {
            ListItem()
            {
              Row()
              {
                Image($r('app.media.setting'))
                  .width(30)
                  .height(30)
                  .margin(10)
                Text('修改个人信息').fontSize(20).fontColor('#000000')
              }
            }
            .height(60)

            ListItem()
            {
              Row()
              {
                Image('/assets/ic_out.svg')
                  .width(30)
                  .height(30)
                  .margin(10)
                Text('退出登录').fontSize(20).fontColor('#ff050505')
              }
            }
            .height(60)
          }
          .padding(5)
          .divider({
            strokeWidth: 1,
            startMargin: 60,
            endMargin: 10,
            color: '#ffdbdbdb'
          })
          .backgroundColor('#ffffffff')
        }
        .width('95%')
        .padding({bottom:5,top:5})
        .borderRadius(10)

    }.width('100%').height('100%').backgroundColor('#6ae7e7e7')
  }
}