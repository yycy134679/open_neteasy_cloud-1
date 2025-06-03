import { Song } from './Song';

/**
 * 歌单实体类
 */
export class Playlist {
  /**
   * 歌单ID
   */
  id: string;

  /**
   * 歌单名称
   */
  name: string;

  /**
   * 歌单描述
   */
  description: string;

  /**
   * 歌单封面URL
   */
  coverUrl: string;

  /**
   * 歌单中的歌曲列表
   */
  songs: Song[];

  /**
   * 创建时间
   */
  createTime: Date;

  /**
   * 播放次数
   */
  playCount: number;

  /**
   * 是否为系统歌单
   */
  isSystem: boolean;

  constructor(
    id: string,
    name: string,
    description: string,
    coverUrl: string,
    songs: Song[] = [],
    createTime: Date = new Date(),
    playCount: number = 0,
    isSystem: boolean = false
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.coverUrl = coverUrl;
    this.songs = songs;
    this.createTime = createTime;
    this.playCount = playCount;
    this.isSystem = isSystem;
  }

  /**
   * 添加歌曲到歌单
   */
  addSong(song: Song): void {
    if (!this.songs.find(s => s.id === song.id)) {
      this.songs.push(song);
    }
  }

  /**
   * 从歌单中移除歌曲
   */
  removeSong(songId: string): void {
    this.songs = this.songs.filter(song => song.id !== songId);
  }

  /**
   * 获取歌单总时长
   */
  getTotalDuration(): number {
    return this.songs.reduce((total, song) => total + song.duration, 0);
  }

  /**
   * 获取格式化的总时长
   */
  getFormattedTotalDuration(): string {
    const totalSeconds = this.getTotalDuration();
    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    
    if (hours > 0) {
      return `${hours}小时${minutes}分钟`;
    } else {
      return `${minutes}分钟`;
    }
  }

  /**
   * 获取歌曲数量
   */
  getSongCount(): number {
    return this.songs.length;
  }

  /**
   * 增加播放次数
   */
  incrementPlayCount(): void {
    this.playCount++;
  }

  /**
   * 检查歌单是否包含指定歌曲
   */
  containsSong(songId: string): boolean {
    return this.songs.some(song => song.id === songId);
  }

  /**
   * 清空歌单
   */
  clear(): void {
    if (!this.isSystem) {
      this.songs = [];
    }
  }
}
