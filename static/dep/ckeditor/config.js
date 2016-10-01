/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {

    config.language = 'zh-cn';
    config.uiColor = '#EEEEEE';
    config.font_names = '微软雅黑;新宋体;宋体;黑体;隶书;幼圆;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana'; //编辑字体设置
    // Set the most common block elements.
    //config.format_tags = 'p;h1;h2;h3;pre';
    // Simplify the dialog windows.
    //config.removeDialogTabs = 'image:advanced;link:advanced';

    config.toolbarCanCollapse = true;
    config.toolbarStartupExpanded = false;

    //预览区域显示内容
    config.image_previewText = ' ';
    //设置引用路径
    config.filebrowserBrowseUrl = '/static/dep/ckfinder/ckfinder.aspx';
    config.filebrowserImageBrowseUrl = '/static/dep/ckfinder/ckfinder.aspx?Type=Images';
    config.filebrowserFlashBrowseUrl = '/static/dep/ckfinder/ckfinder.aspx?Type=Flash';
    config.filebrowserUploadUrl = '/static/dep/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files';
    config.filebrowserImageUploadUrl = '/static/dep/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images';
    config.filebrowserFlashUploadUrl = '/static/dep/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Flash';
    //设置编辑器长宽属性
    config.filebrowserWindowWidth = '800';
    config.filebrowserWindowHeight = '600';
};
