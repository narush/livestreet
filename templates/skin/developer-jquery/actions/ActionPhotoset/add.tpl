{include file='header.tpl' menu='topic_action' showWhiteBack=true}


{if $oConfig->GetValue('view.tinymce')}
	<script src="{cfg name='path.root.engine_lib'}/external/tinymce/tiny_mce.js"></script>
	<script>tinyMCE.init(getTinymceTopicSettings());</script>
{else}
	{include file='window_load_img.tpl' sToLoad='topic_text'}
	
	<script>
		jQuery(document).ready(function($){
			ls.lang.load({lang_load name="panel_b,panel_i,panel_u,panel_s,panel_url,panel_url_promt,panel_code,panel_video,panel_image,panel_cut,panel_quote,panel_list,panel_list_ul,panel_list_ol,panel_title,panel_clear_tags,panel_video_promt,panel_list_li,panel_image_promt,panel_user,panel_user_promt"});
			// Подключаем редактор		
			$('#topic_text').markItUp(getMarkitupSettings());
		});
	</script>
{/if}


<script>
	if (jQuery.browser.flash) {
		ls.photoset.initSwfUpload({
			post_params: { 'topic_id': {json var=$_aRequest.topic_id} }
		});
	}
</script>


<div class="topic" style="display: none;">
	<div class="content" id="text_preview"></div>
</div>


{if $sEvent=='add'}
	<h2 class="page-header">{$aLang.topic_photoset_create}</h2>
{else}
	<h2 class="page-header">{$aLang.topic_photoset_edit}</h2>
{/if}


<form id="photoset-upload-form" method="POST" enctype="multipart/form-data" onsubmit="return false;">
	<p id="topic-photo-upload-input" class="topic-photo-upload-input">
		<label for="">{$aLang.topic_photoset_choose_image}:</label>
		<input type="file" id="photoset-upload-file" name="Filedata" /><br><br>

		<button onclick="ls.photoset.upload();">{$aLang.topic_photoset_upload_choose}</button>
		<button onclick="ls.photoset.closeForm();">{$aLang.topic_photoset_upload_close}</button>
		<input type="hidden" name="is_iframe" value="true" />
		<input type="hidden" name="topic_id" value="{$_aRequest.topic_id}" />
	</p>
</form>
	

{hook run='add_topic_photoset_begin'}


<form action="" method="POST" enctype="multipart/form-data">
	{hook run='form_add_topic_photoset_begin'}
	
	
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" /> 
	
	
	<p><label for="blog_id">{$aLang.topic_create_blog}</label>
	<select name="blog_id" id="blog_id" onChange="ls.blog.loadInfo(this.value);" class="input-width-full">
		<option value="0">{$aLang.topic_create_blog_personal}</option>
		{foreach from=$aBlogsAllow item=oBlog}
			<option value="{$oBlog->getId()}" {if $_aRequest.blog_id==$oBlog->getId()}selected{/if}>{$oBlog->getTitle()|escape:'html'}</option>
		{/foreach}     					
	</select></p>
	
	
	<script>
		jQuery(document).ready(function($){
			ls.blog.loadInfo($('#blog_id').val());
		});
	</script>
	
	
	<p><label for="topic_title">{$aLang.topic_create_title}:</label>
	<input type="text" id="topic_title" name="topic_title" value="{$_aRequest.topic_title}" class="input-text input-width-full" /><br />
	<small class="note">{$aLang.topic_create_title_notice}</small></p>

	
	<p><label for="topic_text">{$aLang.topic_create_text}{if !$oConfig->GetValue('view.tinymce')} ({$aLang.topic_create_text_notice}){/if}:</label>
	<textarea name="topic_text" class="mceEditor input-text input-width-full" id="topic_text" rows="20">{$_aRequest.topic_text}</textarea></p>
	
	
	<div class="topic-photo-upload">
		<h2>{$aLang.topic_photoset_upload_title}</h2>
		
		<div class="topic-photo-upload-rules">
			{$aLang.topic_photoset_upload_rules|ls_lang:"SIZE%%`$oConfig->get('module.topic.photoset.photo_max_size')`":"COUNT%%`$oConfig->get('module.topic.photoset.count_photos_max')`"}
		</div>
		
		<input type="hidden" name="topic_main_photo" id="topic_main_photo" value="{$_aRequest.topic_main_photo}" />
		
		<ul id="swfu_images">
			{if count($aPhotos)}
				{foreach from=$aPhotos item=oPhoto}
					{if $_aRequest.topic_main_photo && $_aRequest.topic_main_photo == $oPhoto->getId()}
						{assign var=bIsMainPhoto value=true}
					{/if}
					
					<li id="photo_{$oPhoto->getId()}" {if $bIsMainPhoto}class="marked-as-preview"{/if}>
						<img src="{$oPhoto->getWebPath('100crop')}" alt="image" />
						<textarea onBlur="ls.photoset.setPreviewDescription({$oPhoto->getId()}, this.value)">{$oPhoto->getDescription()}</textarea><br />
						<a href="javascript:ls.photoset.deletePhoto({$oPhoto->getId()})" class="image-delete">{$aLang.topic_photoset_photo_delete}</a>
						<span id="photo_preview_state_{$oPhoto->getId()}" class="photo-preview-state">
							{if $bIsMainPhoto}
								{$aLang.topic_photoset_is_preview}
							{else}
								<a href="javascript:ls.photoset.setPreview({$oPhoto->getId()})" class="mark-as-preview">{$aLang.topic_photoset_mark_as_preview}</a>
							{/if}
						</span>
					</li>
					
					{assign var=bIsMainPhoto value=false}
				{/foreach}
			{/if}
		</ul>
		
		<a href="javascript:ls.photoset.showForm()" id="photoset-start-upload">{$aLang.topic_photoset_upload_choose}</a>
	</div>
	
	  
	<p><label for="topic_tags">{$aLang.topic_create_tags}:</label>
	<input type="text" id="topic_tags" name="topic_tags" value="{$_aRequest.topic_tags}" class="input-text input-width-full autocomplete-tags-sep" /><br />
	<small class="note">{$aLang.topic_create_tags_notice}</small></p>

	
	<p><label for="topic_forbid_comment">
	<input type="checkbox" id="topic_forbid_comment" name="topic_forbid_comment" class="input-checkbox" value="1" {if $_aRequest.topic_forbid_comment==1}checked{/if} />
	{$aLang.topic_create_forbid_comment}</label>
	<small class="note">{$aLang.topic_create_forbid_comment_notice}</small></p>

	
	{if $oUserCurrent->isAdministrator()}
		<p><label for="topic_publish_index">
		<input type="checkbox" id="topic_publish_index" name="topic_publish_index" class="input-checkbox" value="1" {if $_aRequest.topic_publish_index==1}checked{/if} />
		{$aLang.topic_create_publish_index}</label>
		<small class="note">{$aLang.topic_create_publish_index_notice}</small></p>
	{/if}

	
	{hook run='form_add_topic_photoset_end'}
			
			
	<button name="submit_topic_publish" class="button button-primary">{$aLang.topic_create_submit_publish}</button>
	<button name="submit_preview" onclick="jQuery('#text_preview').parent().show(); ls.tools.textPreview('topic_text',true); return false;" class="button">{$aLang.topic_create_submit_preview}</button>
	<button name="submit_topic_save" class="button">{$aLang.topic_create_submit_save}</button>
</form>
	
	
{hook run='add_topic_photoset_end'}



{include file='footer.tpl'}