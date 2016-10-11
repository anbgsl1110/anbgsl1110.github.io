/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	
	config.language = 'zh-cn';  //设置语言
	//界面的语言配置 设置为'zh-cn'即可
	config.defaultLanguage = 'zh-cn';
	//设置是使用绝对目录还是相对目录，为空为相对目录
	config.baseHref = '';
	//所需要添加的CSS文件 在此添加 可使用相对路径和网站的绝对路径
	//config.contentsCss = './contents.css';
	//背景的不透明度 数值应该在：0.0～1.0 之间 plugins/dialog/plugin.js
	config.dialog_backgroundCoverOpacity = 0.5
	//移动或者改变元素时 边框的吸附距离 单位：像素 plugins/dialog/plugin.js
	config.dialog_magnetDistance = 20;
	//进行表格编辑功能 如：添加行或列 目前仅firefox支持 plugins/wysiwygarea/plugin.js
	config.disableNativeTableHandles = false; //默认为不开启
	//是否开启 图片和表格 的改变大小的功能 config.disableObjectResizing = true;
	config.disableObjectResizing = false //默认为开启
	//字体编辑时的字符集 可以添加常用的中文字符：宋体、楷体、黑体等 
	config.font_names = 'Arial;Times New Roman;Verdana;宋体;楷体;黑体;微软雅黑';
	//文字的默认式样 
	config.font_style =
    {
        element   : 'span',
        styles   : { 'font-family' : '#(family)' },
        overrides : [ { element : 'font', attributes : { 'face' : null } } ]
    };

	//字体默认大小 
	config.fontSize_defaultLabel = '12px';
	//字体编辑时可选的字体大小 plugins/font/plugin.js
	config.fontSize_sizes ='8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;72/72px'
	//设置字体大小时 使用的式样 plugins/font/plugin.js
	config.fontSize_style =
		{
			element   : 'span',
			styles   : { 'font-size' : '#(size)' },
			overrides : [ { element : 'font', attributes : { 'size' : null } } ]
		};
	//是否强制复制来的内容去除格式 plugins/pastetext/plugin.js
	config.forcePasteAsPlainText =false //不去除
	
	//是否强制用“&”来代替“&”plugins/htmldataprocessor/plugin.js
	config.forceSimpleAmpersand = false;

	//设置高度
	config.height=400;   
	//设置宽度
	config.width=650;    
	//当从word里复制文字进来时，是否进行文字的格式化去除 plugins/pastefromword/plugin.js
	config.pasteFromWordIgnoreFontFace = true; //默认为忽略格式
	//从word中粘贴内容时是否移除格式 plugins/pastefromword/plugin.js
	config.pasteFromWordRemoveStyle = false
	//可选界面包 
	config.skin = 'office2003';
	//默认使用的模板 plugins/templates/plugin.js.
	config.templates = 'default'
	//主题
	config.theme = 'default';
	//当用户键入TAB时，编辑器走过的空格数，( ) 当值为0时，焦点将移出编辑框 plugins/tab/plugin.js
	config.tabSpaces = 10
	
	//使用的工具栏 plugins/toolbar/plugin.js
	config.toolbar = 'Full'

	//需要下面的配合 
	config.toolbar_Full =
	[
		['Bold', 'Italic', 'Underline', 'Strike'],['Format', 'Font', 'FontSize','TextColor','BGColor'],
		'/',
		['Subscript','Superscript'],
		['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
		['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
		['Link','Unlink','Anchor'],
		['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar'],
		'/',
		['Source','-','Save','NewPage','Preview','-','Templates'],
		['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
		['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat']
		
	];
	//工具栏是否可以被收缩 plugins/toolbar/plugin.js.
	config.toolbarCanCollapse = true
	
	//工具栏的位置 plugins/toolbar/plugin.js
	config.toolbarLocation = 'top';//可选：bottom
	
	//工具栏默认是否展开 plugins/toolbar/plugin.js
	config.toolbarStartupExpanded = true;
	config.filebrowserImageUploadUrl= 'UpCKImgFile.aspx'
	config.filebrowserFlashUploadUrl= 'UpCKFlashFile.aspx'
	config.filebrowserLinkUploadUrl= 'UpCKLinkFile.aspx'
};
