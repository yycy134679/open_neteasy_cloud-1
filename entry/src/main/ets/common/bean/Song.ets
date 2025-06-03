/**
 * 音乐实体类
 */
export class Song {
  /**
   * 歌曲ID
   */
  id: string;

  /**
   * 歌曲标题
   */
  title: string;

  /**
   * 艺术家
   */
  artist: string;

  /**
   * 专辑名称
   */
  album: string;

  /**
   * 歌曲时长（秒）
   */
  duration: number;

  /**
   * 封面图片URL
   */
  coverUrl: string;

  /**
   * 音频文件URL
   */
  audioUrl: string;

  /**
   * 歌词（可选）
   */
  lyrics?: string;

  /**
   * 是否收藏
   */
  isFavorite: boolean;

  /**
   * 播放次数
   */
  playCount: number;

  constructor(
    id: string,
    title: string,
    artist: string,
    album: string,
    duration: number,
    coverUrl: string,
    audioUrl: string,
    lyrics?: string,
    isFavorite: boolean = false,
    playCount: number = 0
  ) {
    this.id = id;
    this.title = title;
    this.artist = artist;
    this.album = album;
    this.duration = duration;
    this.coverUrl = coverUrl;
    this.audioUrl = audioUrl;
    this.lyrics = lyrics;
    this.isFavorite = isFavorite;
    this.playCount = playCount;
  }

  /**
   * 格式化时长为 mm:ss 格式
   */
  getFormattedDuration(): string {
    const minutes = Math.floor(this.duration / 60);
    const seconds = this.duration % 60;
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  /**
   * 切换收藏状态
   */
  toggleFavorite(): void {
    this.isFavorite = !this.isFavorite;
  }

  /**
   * 增加播放次数
   */
  incrementPlayCount(): void {
    this.playCount++;
  }
}
