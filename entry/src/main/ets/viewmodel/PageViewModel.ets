import { CommonConstants } from '../common/constants/CommonConstants';
import { Category } from '../common/bean/Category';
import { ListItemData } from '../common/bean/ListItemData';

/**
 * 分类列表页面视图模型。
 */
class PageViewModel {
  /**
   * Get category data.
   *
   * @return {Array<Category>} categoryData
   */
  getCategoryData(): Array<Category> {
    let categoryData: Array<Category> = [];
    for (let i = 0; i < CommonConstants.CATEGORY_CONTENT_LIST_SIZE; i++) {
      let categoryItem = new Category(
        $r('app.string.sub_title'),
        this.getListData(i + CommonConstants.CATEGORY_INCREMENTAL_STEP)
      );
      categoryData.push(categoryItem);
    }
    return categoryData;
  }

  /**
   * Get sub list data in a category.
   *
   * @param {number} itemSize The size of listData of category.
   * @return {Array<ListItemData>} ListData of category.
   */
  private getListData(itemSize: number): Array<ListItemData> {
    let listData: Array<ListItemData> = [];
    for (let i = 0; i < itemSize; i++) {
      let listItem = new ListItemData(
        $r('app.string.list_item_title'),
        $r('app.string.list_item_summary'),
        $r('app.media.ic_right_arrow')
      );
      listData.push(listItem);
    }
    return listData;
  }

  /**
   * Get list data in detail page.
   *
   * @return {Array<ListItemData>} detailData
   */
  getDetailData(): Array<ListItemData> {
    let detailData: Array<ListItemData> = [];
    for (let i = 0; i < CommonConstants.DETAIL_PAGE_LIST_SIZE; i++) {
      let detailItem = new ListItemData(
        $r('app.string.page_title'),
        $r('app.string.list_item_summary'),
        $r('app.media.ic_right_arrow')
      );
      detailData.push(detailItem);
    }
    return detailData;
  }
}

let pageViewModel = new PageViewModel();

export default pageViewModel as PageViewModel;