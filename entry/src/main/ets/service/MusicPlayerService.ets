import { Song } from '../common/bean/Song';

/**
 * 播放模式枚举
 */
export enum PlayMode {
  SEQUENCE = 'sequence',    // 顺序播放
  RANDOM = 'random',        // 随机播放
  REPEAT_ONE = 'repeat_one' // 单曲循环
}

/**
 * 播放状态枚举
 */
export enum PlayState {
  PLAYING = 'playing',
  PAUSED = 'paused',
  STOPPED = 'stopped',
  LOADING = 'loading'
}

/**
 * 时间更新数据接口
 */
interface TimeUpdateData {
  currentTime: number;
  duration: number;
}

/**
 * 音乐播放服务
 * 管理音乐播放的核心逻辑
 */
export class MusicPlayerService {
  private static instance: MusicPlayerService;
  
  // 播放状态
  private _currentSong: Song | null = null;
  private _playlist: Song[] = [];
  private _currentIndex: number = -1;
  private _playState: PlayState = PlayState.STOPPED;
  private _playMode: PlayMode = PlayMode.SEQUENCE;
  private _currentTime: number = 0;
  private _duration: number = 0;
  private _volume: number = 1.0;

  // 事件监听器
  private listeners: Map<string, Function[]> = new Map();

  private constructor() {
    this.initializeListeners();
  }

  /**
   * 获取单例实例
   */
  static getInstance(): MusicPlayerService {
    if (!MusicPlayerService.instance) {
      MusicPlayerService.instance = new MusicPlayerService();
    }
    return MusicPlayerService.instance;
  }

  /**
   * 初始化事件监听器
   */
  private initializeListeners(): void {
    this.listeners.set('play', []);
    this.listeners.set('pause', []);
    this.listeners.set('stop', []);
    this.listeners.set('songChange', []);
    this.listeners.set('timeUpdate', []);
    this.listeners.set('playModeChange', []);
  }

  /**
   * 添加事件监听器
   */
  addEventListener(event: string, callback: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)?.push(callback);
  }

  /**
   * 移除事件监听器
   */
  removeEventListener(event: string, callback: Function): void {
    const callbacks = this.listeners.get(event);
    if (callbacks) {
      const index = callbacks.indexOf(callback);
      if (index > -1) {
        callbacks.splice(index, 1);
      }
    }
  }

  /**
   * 触发事件
   */
  private emit(event: string, data?: Object): void {
    const callbacks = this.listeners.get(event);
    if (callbacks) {
      callbacks.forEach((callback: Function): void => callback(data));
    }
  }

  /**
   * 播放指定歌曲
   */
  play(song?: Song): void {
    if (song) {
      this.setCurrentSong(song);
    }
    
    if (this._currentSong) {
      this._playState = PlayState.PLAYING;
      this._currentSong.incrementPlayCount();
      this.emit('play', this._currentSong);
      
      // 模拟播放进度更新
      this.startTimeUpdate();
    }
  }

  /**
   * 暂停播放
   */
  pause(): void {
    this._playState = PlayState.PAUSED;
    this.emit('pause');
    this.stopTimeUpdate();
  }

  /**
   * 停止播放
   */
  stop(): void {
    this._playState = PlayState.STOPPED;
    this._currentTime = 0;
    this.emit('stop');
    this.stopTimeUpdate();
  }

  /**
   * 播放下一首
   */
  next(): void {
    const nextSong = this.getNextSong();
    if (nextSong) {
      this.play(nextSong);
    }
  }

  /**
   * 播放上一首
   */
  previous(): void {
    const previousSong = this.getPreviousSong();
    if (previousSong) {
      this.play(previousSong);
    }
  }

  /**
   * 设置播放列表
   */
  setPlaylist(songs: Song[], startIndex: number = 0): void {
    this._playlist = songs;
    this._currentIndex = startIndex;
    if (songs.length > 0 && startIndex >= 0 && startIndex < songs.length) {
      this.setCurrentSong(songs[startIndex]);
    }
  }

  /**
   * 设置当前歌曲
   */
  private setCurrentSong(song: Song): void {
    this._currentSong = song;
    this._duration = song.duration;
    this._currentTime = 0;
    
    // 更新当前索引
    const index = this._playlist.findIndex(s => s.id === song.id);
    if (index !== -1) {
      this._currentIndex = index;
    }
    
    this.emit('songChange', song);
  }

  /**
   * 获取下一首歌曲
   */
  private getNextSong(): Song | null {
    if (this._playlist.length === 0) return null;

    switch (this._playMode) {
      case PlayMode.SEQUENCE:
        const nextIndex = (this._currentIndex + 1) % this._playlist.length;
        return this._playlist[nextIndex];
      
      case PlayMode.RANDOM:
        const randomIndex = Math.floor(Math.random() * this._playlist.length);
        return this._playlist[randomIndex];
      
      case PlayMode.REPEAT_ONE:
        return this._currentSong;
      
      default:
        return null;
    }
  }

  /**
   * 获取上一首歌曲
   */
  private getPreviousSong(): Song | null {
    if (this._playlist.length === 0) return null;

    switch (this._playMode) {
      case PlayMode.SEQUENCE:
        const prevIndex = this._currentIndex === 0 ? 
          this._playlist.length - 1 : this._currentIndex - 1;
        return this._playlist[prevIndex];
      
      case PlayMode.RANDOM:
        const randomIndex = Math.floor(Math.random() * this._playlist.length);
        return this._playlist[randomIndex];
      
      case PlayMode.REPEAT_ONE:
        return this._currentSong;
      
      default:
        return null;
    }
  }

  /**
   * 设置播放模式
   */
  setPlayMode(mode: PlayMode): void {
    this._playMode = mode;
    this.emit('playModeChange', mode);
  }

  /**
   * 设置播放进度
   */
  seekTo(time: number): void {
    this._currentTime = Math.max(0, Math.min(time, this._duration));
    const timeData: TimeUpdateData = {
      currentTime: this._currentTime,
      duration: this._duration
    };
    this.emit('timeUpdate', timeData);
  }

  /**
   * 开始时间更新
   */
  private startTimeUpdate(): void {
    this.stopTimeUpdate();
    this.timeUpdateInterval = setInterval(() => {
      if (this._playState === PlayState.PLAYING) {
        this._currentTime += 1;
        if (this._currentTime >= this._duration) {
          this.next(); // 自动播放下一首
        } else {
          const timeData: TimeUpdateData = {
            currentTime: this._currentTime,
            duration: this._duration
          };
          this.emit('timeUpdate', timeData);
        }
      }
    }, 1000);
  }

  /**
   * 停止时间更新
   */
  private stopTimeUpdate(): void {
    if (this.timeUpdateInterval) {
      clearInterval(this.timeUpdateInterval);
      this.timeUpdateInterval = null;
    }
  }

  private timeUpdateInterval: number | null = null;

  // Getters
  get currentSong(): Song | null { return this._currentSong; }
  get playlist(): Song[] { return this._playlist; }
  get currentIndex(): number { return this._currentIndex; }
  get playState(): PlayState { return this._playState; }
  get playMode(): PlayMode { return this._playMode; }
  get currentTime(): number { return this._currentTime; }
  get duration(): number { return this._duration; }
  get volume(): number { return this._volume; }
  get isPlaying(): boolean { return this._playState === PlayState.PLAYING; }
}
