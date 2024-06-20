import media from '@ohos.multimedia.media';
import common from '@ohos.app.ability.common';
import display from '@ohos.display';
@Entry
@Component
struct Index {
  @State screenWidth:number = px2vp(display.getDefaultDisplaySync().width)
  @State screenHeight:number = px2vp(display.getDefaultDisplaySync().height)
  //模拟器可以将屏幕尺寸按如下设置
  // @State screenWidth:number = 330
  // @State screenHeight:number = 780

  @State rotateAngle:number=0;
  @State isPlay:boolean = false;
  private timer?: number;
  @State value: number = 0;

  private count: number = 0;
  private isSeek: boolean = true; // 用于区分模式是否支持seek操作
  private fileSize: number = -1;
  private fd: number = 0;

  @State duration:number = 0
  @State progressNow:number = 0

  @State durationTimeString:string = '00:00'
  @State progressTimeString:string = '00:00'

  private avPlayer?: media.AVPlayer = undefined;
  @State listViewPosition:number = this.screenHeight

  @State musicList:MusicClass[] = [
    new MusicClass('Never Really Easy','Stephanie Poetri','NeverReallyEasy.mp3','NeverReallyEasy.png'),
    new MusicClass('Only Lovers','Ronan Keating','onlylovers.mp3','onlylovers.png'),
    new MusicClass('Bumping Up and Down','Raffi','BumpingUpandDown.mp3','BumpingUpandDown.png')
  ]

  @State currentMusic:MusicClass = this.musicList[0]
  @State currentIndex:number = 0

  onPageShow(): void {
    this.avPlayerUrlDemo()
  }

  startRotate() {
    this.timer = setInterval(() => {
      // 保留2位小数
      this.value = this.value + 0.005

    }, 30);

    if (this.avPlayer != undefined) {
      if(this.avPlayer.state != 'playing'){
        this.avPlayer.play()
      }else {
        this.avPlayer.pause()
      }
    }
  }

  endRotate() {
    clearInterval(this.timer)
    if (this.avPlayer != undefined) {
      this.avPlayer.pause()
    }
  }

  async avPlayerUrlDemo() {
    // // 创建avPlayer实例对象
    // let avPlayer: media.AVPlayer = await media.createAVPlayer();
    // // 创建状态机变化回调函数
    // this.setAVPlayerCallback(avPlayer);
    // this.isSeek = false; // 不支持seek操作
    // avPlayer.url = 'https://cdn.soundstripe.com/uploads/audio_file/381e129db0964d5289ebdaec01f61bf1/mp3_PALA_OneMoreDance_Full.mp3?token=1712968809_026183eab08f6d0f3a7aa5d422212a980252cc82b135e6a9950ee00fc8d74b73';
    // this.avPlayer = avPlayer

    // 创建avPlayer实例对象
    let avPlayer: media.AVPlayer = await media.createAVPlayer();
    // 创建状态机变化回调函数
    this.setAVPlayerCallback(avPlayer);
    // 通过UIAbilityContext的resourceManager成员的getRawFd接口获取媒体资源播放地址
    // 返回类型为{fd,offset,length},fd为HAP包fd地址，offset为媒体资源偏移量，length为播放长度
    let context = getContext(this) as common.UIAbilityContext;
    let fileDescriptor = await context.resourceManager.getRawFd(this.musicList[this.currentIndex].url);
    let avFileDescriptor: media.AVFileDescriptor =
      { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
    this.isSeek = false; // 支持seek操作
    // 为fdSrc赋值触发initialized状态机上报
    avPlayer.fdSrc = avFileDescriptor;
    this.avPlayer = avPlayer
  }


  // 注册avplayer回调函数
  setAVPlayerCallback(avPlayer: media.AVPlayer) {

    avPlayer.on('timeUpdate', (seekDoneTime: number) => {

      if(this.duration > 0){
        let progress = seekDoneTime/this.duration
        this.progressNow = progress*100
      }
      this.progressTimeString = this.durationToTimeString(seekDoneTime)
    })
    // seek操作结果回调函数
    avPlayer.on('seekDone', (seekDoneTime: number) => {
      console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
    })

    // 状态机变化回调函数
    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle': // 成功调用reset接口后触发该状态机上报
          console.info('AVPlayer state idle called.');
          avPlayer.release(); // 调用release接口销毁实例对象
          break;
        case 'initialized': // avplayer 设置播放源后触发该状态上报
          console.info('AVPlayer state initialized called.');
          avPlayer.prepare();
          break;
        case 'prepared': // prepare调用成功后上报该状态机
          console.info('AVPlayer state prepared called.');
          if(this.isPlay){
            avPlayer.play();
          }
          this.duration = avPlayer.duration
          this.durationTimeString = this.durationToTimeString(this.duration)
          console.log('duration:',avPlayer.duration)

          break;
        case 'playing': // play成功调用后触发该状态机上报
          console.info('AVPlayer state playing called.');
          if (this.count !== 0) {
            if (this.isSeek) {
              console.info('AVPlayer start to seek.');
              avPlayer.seek(avPlayer.duration); //seek到音频末尾
            } else {
              // 当播放模式不支持seek操作时继续播放到结尾
              console.info('AVPlayer wait to play end.');
            }
          } else {
            // avPlayer.pause(); // 调用暂停接口暂停播放
          }
          this.count++;
          break;
        case 'paused': // pause成功调用后触发该状态机上报
          console.info('AVPlayer state paused called.');
        // avPlayer.play(); // 再次播放接口开始播放
          break;
        case 'completed': // 播放结束后触发该状态机上报
          console.info('AVPlayer state completed called.');
        // avPlayer.stop(); //调用播放结束接口
        // this.endRotate();
          if(this.currentIndex < this.musicList.length - 1){
            this.currentIndex += 1
            this.changeSong()
          }else {
            this.endRotate();
          }
          break;
        case 'stopped': // stop接口成功调用后触发该状态机上报
          console.info('AVPlayer state stopped called.');
        // avPlayer.reset(); // 调用reset接口初始化avplayer状态
          break;
        case 'released':
          console.info('AVPlayer state released called.');
          break;
        default:
          console.info('AVPlayer state unknown called.');
          break;
      }
    })
  }

  durationToTimeString(duration:number){
    let secondTotal:number = duration/1000
    let minute:number = Math.floor(secondTotal/60)
    let second:number = Math.floor(secondTotal%60)
    return this.padWithZeros(minute,2) + ":" + this.padWithZeros(second,2)
  }
  padWithZeros(number:number, length:number) {
    return String(number).padStart(length, '0');
  }

  changeSong(){
    if(this.avPlayer != undefined){
      this.avPlayer.reset()
    }
    this.avPlayerUrlDemo()
  }
  playOrPause(){
    this.isPlay = !this.isPlay
    if(this.isPlay){
      this.startRotate()
    }else {
      this.endRotate()
    }
  }

  @Builder NavigationTitle() {
    Row(){
      Text("朋友圈")
        .width('100')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Gray)
    .margin({right:100})
  }
  @Builder NavigationMenus() { // CustomBuilder类型的菜单栏
    Row() {
      Image($r('app.media.nav_down'))
        .size({ width: 25, height: 25 })
        .margin({ left: 20 })
      Row(){
        Text('相关')
          .fontSize(14)
          .fontColor('#76777A')
          .margin({right:20})
        Text('歌曲')
          .fontSize(14)
          .fontColor('#222628')
          .margin({right:20})
        Text('歌词')
          .fontSize(14)
          .fontColor('#76777A')
      }
      Image($r('app.media.nav_share'))
        .size({ width: 25, height: 25 })
        .margin({ right: 20 })
    }
    .width('100%')
    .height('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }


  build() {
    Stack({alignContent:Alignment.Bottom}){
      Flex({direction:FlexDirection.Column,justifyContent:FlexAlign.SpaceBetween}){
        Row() {
          Image($r('app.media.nav_down'))
            .size({ width: 25, height: 25 })
          Row(){
            Text('相关')
              .fontSize(14)
              .fontColor('#76777A')
              .margin({right:20})
            Text('歌曲')
              .fontSize(14)
              .fontColor('#222628')
              .margin({right:20})
            Text('歌词')
              .fontSize(14)
              .fontColor('#76777A')
          }
          Image($r('app.media.nav_share'))
            .size({ width: 25, height: 25 })
        }
        .width('100%')
        .height(68)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row(){
          Image($rawfile(this.musicList[this.currentIndex].cover))
            .width(this.screenWidth - 50)
            .height(this.screenWidth - 50)
            .borderRadius((this.screenWidth - 50)/2)
            .objectFit(ImageFit.Fill)
            .rotate({ x: 0, y: 0, z: 1, angle: this.value*360 })
        }
        .margin({top:10})
        .justifyContent(FlexAlign.Center)
        .width('100%')

        Column(){
          Text(this.musicList[this.currentIndex].title)
            .fontColor('#222628')
            .fontSize(24)

          Text(this.musicList[this.currentIndex].singer)
            .fontColor('#76777A')
            .fontSize(14)
            .margin({top:10})
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        Column(){
          Row(){
            Image($r('app.media.tool_like'))
              .width(24)
              .height(24)
            Image($r('app.media.tool_slider'))
              .width(24)
              .height(24)
            Image($r('app.media.tool_down'))
              .width(24)
              .height(24)
            Image($r('app.media.tool_comment'))
              .width(24)
              .height(24)
            Image($r('app.media.tool_more'))
              .width(24)
              .height(24)
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .height(50)

          Column(){
            Progress({ value: this.progressNow, total: 100, type: ProgressType.Linear }) // 创建一个进度总长为100，初始进度值为24的线性进度条
              .width('100%')
              .margin({top:20})
              .backgroundColor('rgb(239,239,239)')
              .color(Color.White)
            Row(){
              Text(this.progressTimeString)
                .fontColor('#76777A')
                .fontSize(13)
                .fontWeight(200)
              Text(this.durationTimeString)
                .fontColor('#76777A')
                .fontSize(13)
                .fontWeight(200)
            }
            .width('100%')
            .margin({top:10})
            .justifyContent(FlexAlign.SpaceBetween)
          }

          Row(){
            Image($r('app.media.control_loop'))
              .width(25)
              .height(25)
            Image($r('app.media.control_last'))
              .width(32)
              .height(32)
              .objectFit(ImageFit.Auto)
              .onClick(()=>{
                if(this.currentIndex > 0){
                  this.currentIndex -= 1
                  this.changeSong()
                }
              })
            Image( this.isPlay ? $r('app.media.control_pause') : $r('app.media.control_play'))
              .width(64)
              .height(64)
              .onClick(()=>{
                this.playOrPause()
              })
            Image($r('app.media.control_next'))
              .width(32)
              .height(32)
              .objectFit(ImageFit.Auto)
              .onClick(()=>{

                if(this.currentIndex < this.musicList.length - 1){
                  this.currentIndex += 1
                  this.changeSong()
                }

              })
            Image($r('app.media.control_list'))
              .width(25)
              .height(25)
              .onClick(()=>{
                animateTo({
                  duration: 200,
                }, () => {

                  let y = 20 + 40 + 62*this.musicList.length
                  this.listViewPosition = this.screenHeight - y
                })
              })
          }
          .margin({top:30})
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .margin({bottom:40})

      }
      .width('100%')
      .height('100%')
      .padding({left:20,right:20})
      .radialGradient({
        center: [this.screenWidth/2, this.screenHeight/2],
        radius: this.screenWidth*2,
        colors: [[0xE0EEFF, 0.0], [0xE4F2FF, 0.3], [0xFBD4FF, 1]]
      })

      ListView({musicList:$musicList,currentIndex:this.currentIndex,isPlaying:this.isPlay,
        playAction:(index:number)=>{
          this.currentIndex = index
          if(!this.isPlay){
            this.startRotate()
            this.isPlay = true
          }
          this.changeSong()
        },
        pauseAction:()=>{
          this.playOrPause()
        },
        pansEnd:()=>{
          animateTo({
            duration: 200,
          }, () => {
            this.listViewPosition = this.screenHeight
          })
        }})
        .position({y:this.listViewPosition})

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


@CustomDialog
export struct ListView {
  controller: CustomDialogController
  @Link musicList: MusicClass[]
  @Prop currentIndex: number
  @Prop isPlaying: boolean

  private panOption: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Down })
  pansEnd = () => {}
  pauseAction = () => {}
  playAction = (index:number) => {}

  build() {
    Column(){
      Row(){
        Row(){
        }
        .width(40)
        .height(4)
        .backgroundColor('rgb(234,235,237)')
        .borderRadius(2)
      }
      .height(20)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .onTouch((event?: TouchEvent) => {

      })
      .gesture(
        PanGesture(this.panOption)
          .onActionStart((event?: GestureEvent) => {
            console.info('Pan start')
          })
          .onActionUpdate((event?: GestureEvent) => {
            if (event) {
              console.info('event:',JSON.stringify(event))
              let globalY:number = event['globalY'];

            }
          })
          .onActionEnd(() => {
            console.info('Pan end')
            this.pansEnd()
          })
      )

      Row(){
        Text('当前播放')
          .fontSize(17)
          .fontWeight(600)
          .margin({left:20})
      }
      .height(40)
      .alignItems(VerticalAlign.Center)

      Divider()
        .width('100%')
        .height(0.8)
        .backgroundColor('rgb(226,226,226)')
      List({space:0}){
        ForEach(this.musicList,(item:MusicClass,index)=>{
          ListItem(){
            Row(){
              Column(){
                Text(item.title)
                  .fontColor('#222628')
                  .fontSize(16)
                Text(item.singer)
                  .fontColor('#76777A')
                  .fontSize(12)
                  .margin({top:8})
              }
              .alignItems(HorizontalAlign.Start)

              if(this.currentIndex == index && this.isPlaying){
                Image($r('app.media.list_pause'))
                  .width(28)
                  .height(28)
                  .onClick(()=>{
                    this.pauseAction()
                  })
              }else{
                Image($r('app.media.list_play'))
                  .width(28)
                  .height(28)
                  .onClick(()=>{
                    this.playAction(index)
                  })
              }
            }
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .height(62)
          }
        })
      }
      .divider({strokeWidth:0.5,color:'rgb(236,236,236)'})
      .padding({left:20,right:20})
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius({topLeft:20,topRight:20})
    .shadow({ radius: 30, color: 'rgba(230,230,230,0.7)', offsetX: 0, offsetY: -20 })

  }
}