import { FormData } from '@ohos/axios';
import http from '@ohos.net.http';
import { fetch } from '@system.fetch';

let httpRequest = http.createHttp();

httpRequest.request(
  "EXAMPLE_URL",
  {
    method: http.RequestMethod.POST,
    extraData: {
      data: FormData,
    },
  }
)


export default {
  data: {
    selectedFile: null,
  },

  render() {
    Column() {
      Text('Upload File')
        .fontSize(30)
        .fontWeight('bold')
        .padding(20);
      // 文件输入
      Input({
        type: 'file',
        onChange: (event) => this.onFileChange(event)
      })
        .width('90%')
        .margin({ bottom: 20 });
      // 上传按钮
      Button('Upload')
        .onClick(() => this.uploadFile())
        .padding(10)
        .backgroundColor('#6200EE')
        .fontColor('#FFFFFF')
        .width('90%');
    }.padding(20).width('100%').height('100%').justifyContent('center').alignItems('center');
  },

  // 处理文件选择
  onFileChange(event) {
    const files = event.target.files;
    if (files.length > 0) {
      this.selectedFile = files[0];
    }
  },

  // 上传文件
  async uploadFile() {
    if (!this.selectedFile) {
      console.log('No file selected.');
      return;
    }

    const formData = new FormData();
    formData.append('file', this.selectedFile);

    try {
      const response = await fetch({
        url: 'http://127.0.0.1:5000/upload', // 修改为后端URL
        method: 'POST',
        data: formData,
        header: {
          'Content-Type': 'multipart/form-data',
        },
      });

      if (response.code === 200) {
        console.log('File uploaded successfully.');
      } else {
        console.log('File upload failed.');
      }
    } catch (error) {
      console.error('Error uploading file:', error);
    }
  }
};
