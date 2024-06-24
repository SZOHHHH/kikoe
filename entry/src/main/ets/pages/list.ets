import { MusicList } from '../viewmodel/MusicListViewModel';
@Component
export struct list {
  @State editFlag: boolean = false

  build()
  {
    Stack({alignContent: Alignment.TopStart})
    {
      Column(){
        List({space:20, initialIndex:0})
        {
          ForEach(MusicList, (item, index) =>
          {
            ListItem()
            {
              Flex({direction: FlexDirection.Row, alignItems: ItemAlign.Center})
              {
                Text(item.title)
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
                    Text("删除").fontSize(16)
                  }.width('30%').height(40)
                  .onClick(() =>
                  {
                    console.info(MusicList[index] + 'Delete')
                    MusicList.splice(index, 1)
                    console.info(JSON.stringify(MusicList))
                    this.editFlag = false
                  }).stateEffect(true)
                }
              }
            }
          }, item => item)
        }.width('90%').scrollBar(BarState.Auto)
      }.width('100%')

      Button('编辑')
        .onClick(() =>
        {
          this.editFlag = !this.editFlag
        }).margin({ top: 5, left: 20 })
    }.width('100%').height('100%').backgroundColor(0xDCDCDC).padding({ top: 5 })
  }
}

class MusicClass{

  title:string
  singer:string
  url:string
  cover:string

  constructor(title:string,singer:string,url:string,cover:string) {
    this.title = title
    this.singer = singer
    this.url = url
    this.cover = cover
  }
}

/*
  @State musicList:MusicClass[] = [
    new MusicClass('Never Really Easy','Stephanie Poetri','NeverReallyEasy.mp3','NeverReallyEasy.png'),
    new MusicClass('Only Lovers','Ronan Keating','onlylovers.mp3','onlylovers.png'),
    new MusicClass('Bumping Up and Down','Raffi','BumpingUpandDown.mp3','BumpingUpandDown.png'),
    new MusicClass('yuyi','yorushika','yuyi.mp3','yuyi.png')
  ]
 */