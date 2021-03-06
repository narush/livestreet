{assign var="sidebarPosition" value='left'}
{include file='header.tpl'}

{assign var="oSession" value=$oUserProfile->getSession()}
{assign var="oVote" value=$oUserProfile->getVote()}
			
			
<div class="profile">
	<img src="{$oUserProfile->getProfileAvatarPath(48)}" alt="avatar" class="avatar" />
	
	<div id="vote_area_user_{$oUserProfile->getId()}" class="vote {if $oUserProfile->getRating()>=0}vote-count-positive{else}vote-count-negative{/if} {if $oVote} voted {if $oVote->getDirection()>0}voted-up{elseif $oVote->getDirection()<0}voted-down{/if}{/if}">
		<a href="#" class="vote-up" onclick="return ls.vote.vote({$oUserProfile->getId()},this,1,'user');"></a>
		<div id="vote_total_user_{$oUserProfile->getId()}" class="vote-count" title="{$aLang.user_vote_count}: {$oUserProfile->getCountVote()}">{$oUserProfile->getRating()}</div>
		<a href="#" class="vote-down" onclick="return ls.vote.vote({$oUserProfile->getId()},this,-1,'user');"></a>
	</div>
	
	<p class="strength">
		{$aLang.user_skill}: <strong class="total" id="user_skill_{$oUserProfile->getId()}">{$oUserProfile->getSkill()}</strong>
	</p>

	
	<h2 class="page-header user-login">{$oUserProfile->getLogin()}</h2>
	
	{if $oUserProfile->getProfileName()}
		<p class="user-name">{$oUserProfile->getProfileName()|escape:'html'}</p>
	{/if}

	{if $oUserCurrent && $oUserCurrent->getId()!=$oUserProfile->getId()}				
		<ul id="profile_actions">
			{include file='actions/ActionProfile/friend_item.tpl' oUserFriend=$oUserProfile->getUserFriend()}
			<li><a href="{router page='talk'}add/?talk_users={$oUserProfile->getLogin()}">{$aLang.user_write_prvmsg}</a></li>						
		</ul>
	{/if}	
</div>

<h3 class="profile-page-header">Стена</h3>


{include file='menu.profile.tpl'}



{if $oUserProfile->getProfileIcq()}
	<h3>{$aLang.profile_social_contacts}</h3>
	
	<ul>
		{if $oUserProfile->getProfileIcq()}
			<li>ICQ: <a href="http://www.icq.com/people/about_me.php?uin={$oUserProfile->getProfileIcq()|escape:'html'}" target="_blank">{$oUserProfile->getProfileIcq()}</a></li>
		{/if}					
	</ul>
{/if}

{if $oUserProfile->getProfileSex()!='other' || $oUserProfile->getProfileBirthday() || ($oUserProfile->getProfileCountry() || $oUserProfile->getProfileRegion() || $oUserProfile->getProfileCity()) || $oUserProfile->getProfileAbout() || $oUserProfile->getProfileSite() || count($aUserFields)}
	<h2>{$aLang.profile_privat}</h2>
	<table class="table">		
		{if $oUserProfile->getProfileSex()!='other'}
			<tr>
				<td>{$aLang.profile_sex}:</td>
				<td>
					{if $oUserProfile->getProfileSex()=='man'}
						{$aLang.profile_sex_man}
					{else}
						{$aLang.profile_sex_woman}
					{/if}
				</td>
			</tr>
		{/if}
			
		{if $oUserProfile->getProfileBirthday()}
			<tr>
				<td>{$aLang.profile_birthday}:</td>
				<td>{date_format date=$oUserProfile->getProfileBirthday() format="j F Y"}</td>
			</tr>
		{/if}
		
		{if ($oUserProfile->getProfileCountry()|| $oUserProfile->getProfileRegion() || $oUserProfile->getProfileCity())}
			<tr>
				<td>{$aLang.profile_place}:</td>
				<td>
				{if $oUserProfile->getProfileCountry()}
					<a href="{router page='people'}country/{$oUserProfile->getProfileCountry()|escape:'html'}/">{$oUserProfile->getProfileCountry()|escape:'html'}</a>{if $oUserProfile->getProfileCity()},{/if}
				{/if}						
				{if $oUserProfile->getProfileCity()}
					<a href="{router page='people'}city/{$oUserProfile->getProfileCity()|escape:'html'}/">{$oUserProfile->getProfileCity()|escape:'html'}</a>
				{/if}
				</td>
			</tr>
		{/if}
							
		{if $oUserProfile->getProfileAbout()}					
			<tr>
				<td>{$aLang.profile_about}:</td>
				<td>{$oUserProfile->getProfileAbout()|escape:'html'}</td>
			</tr>	
		{/if}
		
		{if $oUserProfile->getProfileSite()}
			<tr>
				<td>{$aLang.profile_site}:</td>
				<td>
					<a href="{$oUserProfile->getProfileSite(true)|escape:'html'}" rel="nofollow">
						{if $oUserProfile->getProfileSiteName()}
							{$oUserProfile->getProfileSiteName()|escape:'html'}
						{else}
							{$oUserProfile->getProfileSite()|escape:'html'}
						{/if}
					</a>
				</td>
			</tr>
		{/if}
                {if count($aUserFields)}
                    {foreach from=$aUserFields item=oField}
                        <tr>
                            <td class="var">{$oField->getTitle()|escape:'html'}:</td>
                            <td>{$oField->getValue(true,true)}</td>
                        </tr>
                    {/foreach}
                {/if}
		{hook run='profile_whois_privat_item' oUserProfile=$oUserProfile}
	</table>
{/if}

{hook run='profile_whois_item' oUserProfile=$oUserProfile}

<h2>{$aLang.profile_activity}</h2>
<table class="table">
	{if $aUsersFriend}
		<tr>
			<td>{$aLang.profile_friends}:</td>
			<td>
				{foreach from=$aUsersFriend item=oUser}        						
					<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $oConfig->GetValue('general.reg.invite') and $oUserInviteFrom}
		<tr>
			<td>{$aLang.profile_invite_from}:</td>
			<td>							       						
				<a href="{$oUserInviteFrom->getUserWebPath()}">{$oUserInviteFrom->getLogin()}</a>&nbsp;         					
			</td>
		</tr>
	{/if}
	
	{if $oConfig->GetValue('general.reg.invite') and $aUsersInvite}
		<tr>
			<td>{$aLang.profile_invite_to}:</td>
			<td>
				{foreach from=$aUsersInvite item=oUserInvite}        						
					<a href="{$oUserInvite->getUserWebPath()}">{$oUserInvite->getLogin()}</a>&nbsp; 
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogsOwner}
		<tr>
			<td>{$aLang.profile_blogs_self}:</td>
			<td>							
				{foreach from=$aBlogsOwner item=oBlog name=blog_owner}
					<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_owner.last}, {/if}								      		
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogAdministrators}
		<tr>
			<td>{$aLang.profile_blogs_administration}:</td>
			<td>
				{foreach from=$aBlogAdministrators item=oBlogUser name=blog_user}
					{assign var="oBlog" value=$oBlogUser->getBlog()}
					<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogModerators}
		<tr>
			<td>{$aLang.profile_blogs_moderation}:</td>
			<td>
				{foreach from=$aBlogModerators item=oBlogUser name=blog_user}
					{assign var="oBlog" value=$oBlogUser->getBlog()}
					<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogUsers}
		<tr>
			<td>{$aLang.profile_blogs_join}:</td>
			<td>
				{foreach from=$aBlogUsers item=oBlogUser name=blog_user}
					{assign var="oBlog" value=$oBlogUser->getBlog()}
					<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
				{/foreach}
			</td>
		</tr>
	{/if}

	{hook run='profile_whois_activity_item' oUserProfile=$oUserProfile}
	
	<tr>
		<td>{$aLang.profile_date_registration}:</td>
		<td>{date_format date=$oUserProfile->getDateRegister()}</td>
	</tr>	
	
	{if $oSession}				
		<tr>
			<td>{$aLang.profile_date_last}:</td>
			<td>{date_format date=$oSession->getDateLast()}</td>
		</tr>
	{/if}
</table>


{include file='footer.tpl'}