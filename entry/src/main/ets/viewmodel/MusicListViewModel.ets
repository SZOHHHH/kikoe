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
  new MusicClass('Never Really Easy','Stephanie Poetri','NeverReallyEasy.mp3','NeverReallyEasy.png'),
  new MusicClass('Only Lovers','Ronan Keating','onlylovers.mp3','onlylovers.png'),
  new MusicClass('Bumping Up and Down','Raffi','BumpingUpandDown.mp3','BumpingUpandDown.png'),
  new MusicClass('yuyi','yorushika','yuyi.mp3','yuyi.png')
]

export { MusicList }