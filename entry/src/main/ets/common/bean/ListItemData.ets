/**
 * 列表项数据.
 */
export class ListItemData {
  /**
   * List item title.
   */
  title: Resource;

  /**
   * Summary.
   */
  summary: Resource;

  /**
   * Arrow image.
   */
  imageArrow: Resource;

  constructor(title: Resource, summary: Resource, imageArrow: Resource) {
    this.title = title;
    this.summary = summary;
    this.imageArrow = imageArrow;
  }
}