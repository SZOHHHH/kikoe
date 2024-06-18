import fileIo from '@ohos.fileio'
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import router from '@ohos.router'

@Entry//表示该自定义组件为入口组件
@Component //表示自定义组件
struct Index { //表示组件中的状态变量，状态变量变化会触发UI刷新
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()

  build() {
    Column() {

      Search({ value: this.changeValue, placeholder: '请输入音乐名称+.格式', controller: this.controller })
        .searchButton('选择')
        .width(300)
        .height(50)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 15, weight: 550 })
        .textFont({ size: 15, weight: 500 })
        .copyOption(CopyOptions.InApp)
        .onSubmit(async (value: string) => {
          this.submitValue = value
          router.pushUrl({ url: 'pages/' + this.submitValue })
          let fdPath = 'fd://';
          let context = getContext(this) as common.UIAbilityContext;
          let pathDir = context.filesDir;
          let path = pathDir + '/' + this.submitValue;
          let file = await fs.open(path);
          fdPath = fdPath + '' + file.fd;
        })
        .onChange((value: string) => {
          this.changeValue = value
        })
        .margin(20)
        .offset({y: 20})

      Button({ type: ButtonType.Normal, stateEffect: true })
      {
        Text('返回')
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


    }.width('100%')
  }
}