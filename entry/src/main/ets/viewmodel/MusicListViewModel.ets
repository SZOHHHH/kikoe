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

const MusicList: SongItem[] = [
  { id: 1, title: '1111', singer: 'aaaa', mark: $r('app.media.ic_vip'),
    label: $r('app.media.ic_avatar1'), src: 'boisterous.wav', index:0},
  { id: 2, title: '2222', singer: 'bbbb', mark: $r('app.media.ic_sq'),
    label: $r('app.media.ic_avatar2'), src: 'dynamic.wav', index:1 },
  { id: 3, title: '3333', singer: 'cccc', mark: $r('app.media.ic_vip'),
    label: $r('app.media.ic_avatar16'), src: 'dynamic.wav', index:2 }
]

export { MusicList }