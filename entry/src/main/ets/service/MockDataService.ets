import { Song } from '../common/bean/Song';
import { Playlist } from '../common/bean/Playlist';

/**
 * 模拟数据服务
 * 为开发和演示提供丰富的测试数据
 */
export class MockDataService {
  
  /**
   * 获取模拟歌曲数据
   */
  static getMockSongs(): Song[] {
    return [
      new Song(
        '1',
        '稻香',
        '周杰伦',
        '魔杰座',
        223,
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
        'mock_audio_url_1',
        '对这个世界如果你有太多的抱怨\n跌倒了就不敢继续往前走\n为什么人要这么的脆弱 堕落\n请你打开电视看看\n多少人为生命在努力勇敢的走下去',
        false,
        1250
      ),
      new Song(
        '2',
        '青花瓷',
        '周杰伦',
        '我很忙',
        228,
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
        'mock_audio_url_2',
        '素胚勾勒出青花笔锋浓转淡\n瓶身描绘的牡丹一如你初妆\n冉冉檀香透过窗心事我了然\n宣纸上走笔至此搁一半',
        true,
        2100
      ),
      new Song(
        '3',
        '夜曲',
        '周杰伦',
        '十一月的萧邦',
        237,
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
        'mock_audio_url_3',
        '一群嗜血的蚂蚁被腐肉所吸引\n我面无表情看孤独的风景\n失去你爱哭的人是我\n牵你手需要多少勇气',
        false,
        890
      ),
      new Song(
        '4',
        '告白气球',
        '周杰伦',
        '周杰伦的床边故事',
        203,
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
        'mock_audio_url_4',
        '塞纳河畔 左岸的咖啡\n我手一杯 品尝你的美\n留下唇印的嘴\n花店玫瑰 名字写错谁',
        true,
        1680
      ),
      new Song(
        '5',
        '演员',
        '薛之谦',
        '绅士',
        266,
        'https://p1.music.126.net/cover/109951163071263470.jpg',
        'mock_audio_url_5',
        '简单点说话的方式简单点\n递进的情绪请省略\n你又不是个演员\n别设计那些情节',
        false,
        3200
      ),
      new Song(
        '6',
        '体面',
        '于文文',
        '体面',
        247,
        'https://p1.music.126.net/cover/109951162868126486.jpg',
        'mock_audio_url_6',
        '分手应该体面\n谁都不要说抱歉\n何来亏欠\n我敢给就敢心碎',
        true,
        2800
      )
    ];
  }

  /**
   * 获取模拟歌单数据
   */
  static getMockPlaylists(): Playlist[] {
    const songs = this.getMockSongs();
    
    return [
      new Playlist(
        'playlist_1',
        '我喜欢的音乐',
        '收藏的好听歌曲',
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
        [songs[0], songs[1], songs[3]],
        new Date('2023-01-15'),
        520,
        true
      ),
      new Playlist(
        'playlist_2',
        '华语经典',
        '经典华语流行歌曲合集',
        'https://p1.music.126.net/cover/109951163071263470.jpg',
        [songs[0], songs[1], songs[2], songs[4]],
        new Date('2023-03-20'),
        1200,
        false
      ),
      new Playlist(
        'playlist_3',
        '最近播放',
        '最近播放的歌曲',
        'https://p1.music.126.net/cover/109951162868126486.jpg',
        [songs[3], songs[4], songs[5]],
        new Date('2023-11-01'),
        89,
        true
      ),
      new Playlist(
        'playlist_4',
        '深夜电台',
        '适合深夜聆听的音乐',
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
        [songs[2], songs[5]],
        new Date('2023-10-10'),
        340,
        false
      )
    ];
  }

  /**
   * 获取推荐歌单
   */
  static getRecommendedPlaylists(): Playlist[] {
    return this.getMockPlaylists().slice(1, 4);
  }

  /**
   * 获取用户创建的歌单
   */
  static getUserPlaylists(): Playlist[] {
    return this.getMockPlaylists().filter(playlist => !playlist.isSystem);
  }

  /**
   * 获取系统歌单
   */
  static getSystemPlaylists(): Playlist[] {
    return this.getMockPlaylists().filter(playlist => playlist.isSystem);
  }

  /**
   * 根据关键词搜索歌曲
   */
  static searchSongs(keyword: string): Song[] {
    const songs = this.getMockSongs();
    const lowerKeyword = keyword.toLowerCase();
    
    return songs.filter(song => 
      song.title.toLowerCase().includes(lowerKeyword) ||
      song.artist.toLowerCase().includes(lowerKeyword) ||
      song.album.toLowerCase().includes(lowerKeyword)
    );
  }

  /**
   * 根据ID获取歌曲
   */
  static getSongById(id: string): Song | null {
    const songs = this.getMockSongs();
    return songs.find(song => song.id === id) || null;
  }

  /**
   * 根据ID获取歌单
   */
  static getPlaylistById(id: string): Playlist | null {
    const playlists = this.getMockPlaylists();
    return playlists.find(playlist => playlist.id === id) || null;
  }

  /**
   * 获取热门歌曲
   */
  static getPopularSongs(): Song[] {
    return this.getMockSongs()
      .sort((a, b) => b.playCount - a.playCount)
      .slice(0, 10);
  }

  /**
   * 获取收藏的歌曲
   */
  static getFavoriteSongs(): Song[] {
    return this.getMockSongs().filter(song => song.isFavorite);
  }
}
