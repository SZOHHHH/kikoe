@Component
export struct community {
  private swiperController: SwiperController = new SwiperController()
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()

  build() {
    Column({space:10}) {
      Column({space:10})
      {
        Search({ value: this.changeValue, placeholder: '发现更多热爱', controller: this.controller })
          .searchButton('搜索')
          .width(320)
          .height(40)
          .backgroundColor('#FBFBFB')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit((value: string) => {
            this.submitValue = value
          })
          .onChange((value: string) => {
            this.changeValue = value
          })
          .margin({ top: 10 })
      }
      .width('100%')
      .height(60)
      .linearGradient({
        direction:GradientDirection.Right,
        colors:[
          ['#FFF5EE',0.0],['#FFE4C4',1.0]
        ]
      })

      Column()
      {
        Grid()
        {
          GridItem()
          {
            Column()
            {
              Image('/assets/guitar.png').width(50)
              Text('吉他').fontSize(12).fontColor('#333')
            }.height(60)
          }

          GridItem()
          {
            Column()
            {
              Image('/assets/bass.png').width(50)
              Text('贝斯').fontSize(12).fontColor('#333')
            }.height(60)
          }

          GridItem()
          {
            Column()
            {
              Image('/assets/drum.png').width(50)
              Text('鼓').fontSize(12).fontColor('#333')
            }.height(60)
          }

          GridItem()
          {
            Column()
            {
              Image('/assets/sing.png').width(50)
              Text('伴奏').fontSize(12).fontColor('#333')
            }.height(60)
          }
        }.columnsTemplate('1fr 1fr 1fr 1fr')
      }
      .width('95%')
      .height(80)
      .backgroundColor('#FFF')
      .borderRadius(5)
      .justifyContent(FlexAlign.Center)



      Scroll()
      {
        Column({ space: 15 })
        {
          Swiper(this.swiperController)
          {
            Image('/assets/gbc.jpg')
              .width('95%')
              .height(200)
              .borderRadius(5)

            Image('/assets/bocchi.jpg')
              .width('95%')
              .height(200)
              .borderRadius(5)

            Image('/assets/HTT.jpg')
              .width('95%')
              .height(200)
              .borderRadius(5)

            Image('/assets/MyGO.jpg')
              .width('95%')
              .height(200)
              .borderRadius(5)

          }
          .loop(true)
          .autoPlay(true)
          .interval(1500)

          Column() {
            Image('/assets/longseason.png')
              .width('100%')
              .borderRadius({
                topLeft: 5,
                topRight: 5
              })

            Text("今天的音乐分享 | 《Long Season》-Fishmans")
              .fontWeight(600)
              .fontSize(20)
              .lineHeight(24)
              .height(80)

            Row() {
              //头像、昵称
              Row({ space: 10 }) {
                Image('/assets/man1.png')
                  .width(25)
                  .borderRadius(8)
                Text('小何严选')
                  .fontWeight(500)
                  .fontSize(16)
                  .fontColor('#999')
              }
              .layoutWeight(1)

              //点赞图标、点赞数
              Row({ space: 10 }) {
                Image($r('app.media.tool_like'))
                  .width(20)
                  .fillColor('#FF0000')
                Text('233')
                  .fontSize(16)
                  .fontColor('#666')
              }
            }
            .padding({ left: 10, right: 10 })
          }
          .width('95%')
          .padding({ bottom: 10 })
          .backgroundColor(Color.White)
          .borderRadius(5)


          Column() {
            Image('/assets/red.png')
              .width('100%')
              .borderRadius({
                topLeft: 5,
                topRight: 5
              })

            Text("今天的音乐分享 | 《Starless》-KingCrimson")
              .fontWeight(600)
              .fontSize(20)
              .lineHeight(24)
              .height(80)

            Row() {
              //头像、昵称
              Row({ space: 10 }) {
                Image('/assets/man2.png')
                  .width(25)
                  .borderRadius(8)
                Text('小王严选')
                  .fontWeight(500)
                  .fontSize(16)
                  .fontColor('#999')
              }
              .layoutWeight(1)

              //点赞图标、点赞数
              Row({ space: 10 }) {
                Image($r('app.media.tool_like'))
                  .width(20)
                  .fillColor('#999')
                Text('114')
                  .fontSize(16)
                  .fontColor('#666')
              }
            }
            .padding({ left: 10, right: 10 })
          }
          .width('95%')
          .padding({ bottom: 10 })
          .backgroundColor(Color.White)
          .borderRadius(5)

          Column() {
            Image('/assets/ao.jpg')
              .width('100%')
              .borderRadius({
                topLeft: 5,
                topRight: 5
              })

            Text("今天的音乐分享 | 《機械仕掛乃宇宙》-青叶市子")
              .fontWeight(600)
              .fontSize(20)
              .lineHeight(24)
              .height(80)

            Row() {
              //头像、昵称
              Row({ space: 10 }) {
                Image('/assets/man3.png')
                  .width(25)
                  .borderRadius(8)
                Text('小孙严选')
                  .fontWeight(500)
                  .fontSize(16)
                  .fontColor('#999')
              }
              .layoutWeight(1)

              //点赞图标、点赞数
              Row({ space: 10 }) {
                Image($r('app.media.tool_like'))
                  .width(20)
                  .fillColor('#999')
                Text('514')
                  .fontSize(16)
                  .fontColor('#666')
              }
            }
            .padding({ left: 10, right: 10 })
          }
          .width('95%')
          .padding({ bottom: 10 })
          .backgroundColor(Color.White)
          .borderRadius(5)

          Column()
          {
            Text('—已经到底了—')
              .fontSize(16)
              .fontWeight(28)
              .fontColor('#999')
              .height(100)
          }
          .height(250)
          .width('100%')

        }//column
        .width('100%')

      }//scroll
      .width('100%')
    }
    .width('100%')
    .backgroundColor('#ffc9ffff')
  }
}