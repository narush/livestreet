{include file='header.tpl'}
{include file='menu.talk.tpl'}


<div class="topic" style="display: none;">
	<div class="content" id="text_preview"></div>
</div>


<form action="" method="POST" enctype="multipart/form-data">
	{hook run='form_add_talk_begin'}
	
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />

	<p><label for="talk_users">{$aLang.talk_create_users}:</label>
	<input type="text" class="input-text input-width-full autocomplete-users" id="talk_users" name="talk_users" value="{$_aRequest.talk_users}" /></p>

	<p><label for="talk_title">{$aLang.talk_create_title}:</label>
	<input type="text" class="input-text input-width-full" id="talk_title" name="talk_title" value="{$_aRequest.talk_title}" /></p>

	<p><label for="talk_text">{$aLang.talk_create_text}:</label>
	<textarea name="talk_text" id="talk_text" rows="12" class="input-text input-width-full">{$_aRequest.talk_text}</textarea></p>
	
	{hook run='form_add_talk_end'}
	
	<input type="submit" class="button" value="{$aLang.talk_create_submit}" name="submit_talk_add" />
	<input type="submit" class="button" name="submit_preview" value="{$aLang.topic_create_submit_preview}" onclick="jQuery('#text_preview').parent().show(); ls.tools.textPreview('talk_text',false); return false;" />		
</form>


{include file='footer.tpl'}