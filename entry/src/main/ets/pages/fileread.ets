import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import router from '@ohos.router'
import request from '@ohos.request';
import { FormData } from '@ohos/axios';
import http from '@ohos.net.http';

@Entry//表示该自定义组件为入口组件
@Component //表示自定义组件
struct Index { //表示组件中的状态变量，状态变量变化会触发UI刷新
  @State changeValue: string = ''
  @State submitValue: string = ''
  @State uploadUrl: string = "http://127.0.0.1:5000/upload"
  @State uploadUri: string = ""
  @State msgHistory: string = ''
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
          this.uploadUri = this.submitValue
          this.uploadFile()
          router.pushUrl({ url: 'pages/newmusic'})
          /*
          let fdPath = 'fd://';
          let context = getContext(this) as common.UIAbilityContext;
          let pathDir = context.filesDir;
          let path = pathDir + '/' + this.submitValue;
          let file = await fs.open(path);
          fdPath = fdPath + '' + file.fd;
          */
        })
        .onChange((value: string) => {
          this.changeValue = value
        })
        .margin(20)
        .offset({ y: 20 })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('返回')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#fff6f6f6')
          .fontWeight(FontWeight.Bold)
      }
      .type(ButtonType.Normal)
      .margin({ top: 20 })
      .width('80%')
      .height('6%')
      .borderRadius(8)
      .backgroundColor('#ff000000')
      .onClick(() => {
        router.pushUrl({ url: 'pages/tabs' })
      })
    }.width('100%')
  }

  async uploadFile() {

    let context = getContext(this) as common.UIAbilityContext
    let segments = this.uploadUri.split('/')
    //文件名称
    let fileName = segments[segments.length-1]
    this.msgHistory += `文件名称：${fileName}\r\n`
    //计划复制到的目标路径
    let realUri = context.cacheDir + "/" + fileName

    //复制选择的文件到沙箱cache文件夹
    try {
      let file = await fs.open(this.uploadUri);
      fs.copyFileSync(file.fd, realUri);
      this.msgHistory += '复制到cache成功\r\n'
    } catch (err) {
      this.msgHistory += 'err.code : ' + err.code + ', err.message : ' + err.message;
    }

    let uploadTask: request.UploadTask
    let uploadConfig: request.UploadConfig = {
      url: this.uploadUrl,
      header: { 'Accept': '*/*' },
      method: "POST",
      files: [{ filename: fileName, name: "file", uri: `internal://cache/${fileName}`, type: "mp3" }],
      data: [{ name: 'name', value: 'value' }],
    };

    try {
      request.uploadFile(context, uploadConfig).then((data) => {
        uploadTask = data;
        uploadTask.on("progress", (size, totalSize) => {
          this.msgHistory += `上传进度：${size}/${totalSize}\r\n`
        })
        uploadTask.on("complete", () => {
          this.msgHistory += "上传完成\r\n"
        })
      }).catch((e) => {
        this.msgHistory += "请求失败：" + e.message + "\r\n"
      })
    } catch (err) {
      this.msgHistory += 'err.code : ' + err.code + ', err.message : ' + err.message;
    }

  }

}
