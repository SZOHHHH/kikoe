import http from '@ohos.net.http';
import util from '@ohos.util';
import fs from '@ohos.file.fs';
import request from '@ohos.request';
import picker from '@ohos.file.picker';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct testPage {
  //连接、通讯历史记录
  @State msgHistory: string = ''
  //首页地址
  @State downloadUrl: string = "http://downsc.chinaz.net/Files/DownLoad/sound1/201906/11582.mp3"
  //上传地址
  @State uploadUrl: string = "http://127.0.0.1:5000/uploads"
  //要上传的文件
  @State uploadUri: string = ""
  //下载到本地的路径
  @State localFilePath: string = ""
  //是否允许上传
  @State canUpload: boolean = false

  scroller: Scroller = new Scroller()
  sessionId: string = ""

  build() {
    Row() {
      Column() {
        Text("Request示例")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(10)
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text("上传的文件：")
            .fontSize(14)
            .width(80)
            .flexGrow(0)

          TextInput({ text: this.uploadUri })
            .onChange((value) => {
              this.uploadUri = value
            })
              //.enabled(false)
            .width(110)
            .fontSize(11)
            .flexGrow(1)

          Button("选择")
            .onClick(() => {
              // this.selectFile()
              this.uploadUri = this.localFilePath
            })
            .width(70)
            .fontSize(14)
            .flexGrow(0)
        }
        .width('100%')
        .padding(10)

        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text("上传地址：")
            .fontSize(14)
            .width(80)
            .flexGrow(0)

          TextInput({ text: this.uploadUrl })
            .onChange((value) => {
              this.uploadUrl = value
            })
            .width(100)
            .fontSize(11)
            .flexGrow(1)
          Button("上传")
            .onClick(() => {
              this.uploadFile()
            })
              //.enabled(this.canUpload)
            .width(70)
            .fontSize(14)
            .flexGrow(0)
        }
        .width('100%')
        .padding(10)

        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text("文件地址：")
            .fontSize(14)
            .width(80)
            .flexGrow(0)

          TextInput({ text: this.downloadUrl })
            .onChange((value) => {
              this.downloadUrl = value
            })
            .width(110)
            .fontSize(11)
            .flexGrow(1)

          Button("下载")
            .onClick(() => {
              this.downloadFile()
            })
            .width(70)
            .fontSize(14)
            .flexGrow(0)
        }
        .width('100%')
        .padding(10)

        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text("保存位置：")
            .fontSize(14)
            .width(80)
            .flexGrow(0)

          TextInput({ text: this.localFilePath })
            .width(110)
            .fontSize(11)
            .flexGrow(1)
        }
        .width('100%')
        .padding(10)

        Scroll(this.scroller) {
          Text(this.msgHistory)
            .textAlign(TextAlign.Start)
            .padding(10)
            .width('100%')
            .backgroundColor(0xeeeeee)
        }
        .align(Alignment.Top)
        .backgroundColor(0xeeeeee)
        .height(300)
        .flexGrow(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.On)
        .scrollBarWidth(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .height('100%')
    }
    .height('100%')
  }

  //下载文件
  downloadFile() {
    this.localFilePath = getContext(this).filesDir + "/file.mp3"

    //文件如果已经存在，就删除
    if (fs.accessSync(this.localFilePath)) {
      fs.unlink(this.localFilePath)
    }

    let cfg: request.DownloadConfig = {
      url: this.downloadUrl,
      header: {
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        //这一步很关键，把登录成功后的cookie传递过去
        'Cookie': 'sessionid=' + this.sessionId,
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      },
      filePath: this.localFilePath }

    let downloadTask: request.DownloadTask;

    try {
      request.downloadFile(getContext(this), cfg
        , (err, data) => {
          if (err) {
            console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
            return;
          }
          downloadTask = data;
          downloadTask.on("progress", (size, tot) => {
            this.msgHistory += `下载进度：${size}/${tot}\r\n`
          })
          downloadTask.on("complete", () => {
            this.msgHistory += "下载完成\r\n"
            //读取文件内容并显示
            this.showFileContent(this.localFilePath)
          })
        });
    } catch (err) {
      this.msgHistory += 'err.code : ' + err.code + ', err.message : ' + err.message;
    }
  }

  //显示指定文件的内容
  showFileContent(filePath: string) {
    this.msgHistory += "文件内容：" + "\r\n"
  }

  //上传文件
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

  //选择文件，为简单起见，选择一个不太大的文本文件
  selectFile() {
    console.log('执行了selectfile');
    let documentPicker = new picker.DocumentViewPicker();  //api9的picker有问题使用不了
    let DocumentSelectOptions = new picker.DocumentSelectOptions();
    documentPicker.select(DocumentSelectOptions).then((result) => {
      if (result.length > 0) {
        this.uploadUri = result[0];
        this.msgHistory += "select file: " + this.uploadUri + "\r\n";
        this.canUpload = true
      }
    }).catch((err) => {
      this.msgHistory += 'DocumentViewPicker.select failed ' + err.message + "\r\n";
    });
  }
}