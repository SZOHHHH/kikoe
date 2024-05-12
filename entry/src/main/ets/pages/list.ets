@Component
export struct list {
  @State arr: string[] = ['曲目1', '曲目2', '曲目3', '曲目4', '曲目5', '曲目6', '曲目7', '曲目8', '曲目9', '曲目10']
  @State editFlag: boolean = false

  build()
  {
    Stack({alignContent: Alignment.TopStart})
    {
      Column(){
        List({space:20, initialIndex:0})
        {
          ForEach(this.arr, (item, index) =>
          {
            ListItem()
            {
              Flex({direction: FlexDirection.Row, alignItems: ItemAlign.Center})
              {
                Text('' + item)
                  .width('100%')
                  .height(80)
                  .fontSize(20)
                  .textAlign(TextAlign.Center)
                  .borderRadius(10)
                  .backgroundColor(0xFFFFFF)
                  .flexShrink(1)
                if (this.editFlag)
                {
                  Button()
                  {
                    Text("详情").fontSize(16)
                  }.width('30%').height(40)
                  .onClick(() =>
                  {
                    console.info(this.arr[index] + 'Delete')
                    this.arr.splice(index, 1)
                    console.info(JSON.stringify(this.arr))
                    this.editFlag = false
                  }).stateEffect(true)
                }
              }
            }
          }, item => item)
        }.width('90%')
      }.width('100%')

      Button('编辑')
        .onClick(() =>
        {
          this.editFlag = !this.editFlag
        }).margin({ top: 5, left: 20 })
    }.width('100%').height('100%').backgroundColor(0xDCDCDC).padding({ top: 5 })
  }
}