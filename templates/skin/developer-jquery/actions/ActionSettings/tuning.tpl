{include file='header.tpl' menu='settings' noSidebar=true}



<small class="note note-header input-width-400">Получать уведомление на e-mail:</small>

<form action="{router page='settings'}tuning/" method="POST" enctype="multipart/form-data">
	{hook run='form_settings_tuning_begin'}

	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
	
	<p>
		<label><input {if $oUserCurrent->getSettingsNoticeNewTopic()}checked{/if} type="checkbox" id="settings_notice_new_topic" name="settings_notice_new_topic" value="1" class="input-checkbox" /> {$aLang.settings_tuning_notice_new_topic}</label>
		<label><input {if $oUserCurrent->getSettingsNoticeNewComment()}checked{/if} type="checkbox" id="settings_notice_new_comment" name="settings_notice_new_comment" value="1" class="input-checkbox" /> {$aLang.settings_tuning_notice_new_comment}</label>
		<label><input {if $oUserCurrent->getSettingsNoticeNewTalk()}checked{/if} type="checkbox" id="settings_notice_new_talk" name="settings_notice_new_talk" value="1" class="input-checkbox" /> {$aLang.settings_tuning_notice_new_talk}</label>
		<label><input {if $oUserCurrent->getSettingsNoticeReplyComment()}checked{/if} type="checkbox" id="settings_notice_reply_comment" name="settings_notice_reply_comment" value="1" class="input-checkbox" /> {$aLang.settings_tuning_notice_reply_comment}</label>
		<label><input {if $oUserCurrent->getSettingsNoticeNewFriend()}checked{/if} type="checkbox" id="settings_notice_new_friend" name="settings_notice_new_friend" value="1" class="input-checkbox" /> {$aLang.settings_tuning_notice_new_friend}</label>
	</p>
	
	{hook run='form_settings_tuning_end'}
	
	<input type="submit" name="submit_settings_tuning" value="{$aLang.settings_tuning_submit}" class="button" />
</form>



{include file='footer.tpl'}