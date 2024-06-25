/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { SongItem } from './SongData';

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

const MusicList: MusicClass[] = [
  new MusicClass('glow','keeno','glow.mp3','glow.png'),
  new MusicClass('glow-accompaniment','keeno','glow-accompaniment.wav','glow.png'),
  new MusicClass('glow-vocals','keeno','glow-vocals.wav','glow.png'),
  new MusicClass('yours','keeno','yours.mp3','yours.png'),
  new MusicClass('yours-accompaniment','keeno','yours-accompaniment.wav','yours.png'),
  new MusicClass('yours-vocals','keeno','yours-vocals.wav','yours.png'),
  new MusicClass('aoi','yorushika','aoi.mp3','aoi.png'),
  new MusicClass('aoi-accompaniment','yorushika','aoi-accompaniment.wav','aoi.png'),
  new MusicClass('aoi-vocals','yorushika','aoi-vocals.wav','aoi.png'),
  //new MusicClass('yuyi','yorushika','yuyi.mp3','yuyi.png'),
]

export { MusicList }