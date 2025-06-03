import type { ListItemData } from './ListItemData';

/**
 * 分类项信息
 */
export class Category {

  /**
   * Category title.
   */
  title: Resource;

  /**
   * Category content(a list).
   */
  categoryContent: Array<ListItemData>;

  constructor(title: Resource, categoryContent: Array<ListItemData>) {
    this.title = title;
    this.categoryContent = categoryContent;
  }
}