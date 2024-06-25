import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import router from '@ohos.router'
import request from '@ohos.request';
import http from '@ohos.net.http';
import file from '@ohos.file.fs'
import { FormData } from '@ohos/axios'
import { MusicList } from '../viewmodel/MusicListViewModel';

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
          router.pushUrl({ url: 'pages/yuyi'})
          MusicList.push(new MusicClass('yuyi','yorushika','yuyi.mp3','yuyi.png'))
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
    const url: string = 'http://127.0.0.1:5000/upload';
    const filePath: string = 'yuyi.mp3';

    try {
      const formData = new FormData();
      formData.append('file', filePath);

      const httpRequest = http.createHttp();
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        extraData: formData,
        header: {
          'Content-Type': 'multipart/form-data'
        }
      });

      if (response.responseCode === 200) {
        console.info('File uploaded successfully.');
      } else {
        console.error('Upload failed.');
      }
    } catch (error) {
    console.error('Error during file upload:', error);
    }
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
