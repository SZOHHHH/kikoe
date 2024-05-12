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
    Column()
    {

    }.width('100%').height('96%').justifyContent(FlexAlign.End)
  }
}