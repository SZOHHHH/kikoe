@Component
export struct community {
  private swiperController: SwiperController = new SwiperController()
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()


  build()
  {
    Column({space:20})
    {
      Search({ value: this.changeValue, placeholder: 'Type to search...', controller: this.controller })
        .searchButton('SEARCH')
        .width(320)
        .height(40)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
        .onSubmit((value: string) =>
        {
          this.submitValue = value
        })
        .onChange((value: string) =>
        {
          this.changeValue = value
        })
      .margin({top: 10})

      Swiper(this.swiperController)
      {
        Text("0")
          .width('90%')
          .height('30%')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)

        Text("1")
          .width('90%')
          .height('30%')
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .fontSize(30)

        Text("2")
          .width('90%')
          .height('30%')
          .backgroundColor(Color.Blue)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
      .loop(true)
      .autoPlay(true)
      .interval(1000)
    }.width('100%').height('96%').justifyContent(FlexAlign.Start)
  }
}