<section class="block block-type-stream" id="block_stream">
	<h3><a href="{router page='comments'}" title="{$aLang.block_stream_comments_all}">{$aLang.block_stream}</a></h3>
	
	
	<ul class="nav nav-pills">						
		<li id="block_stream_item_comment" class="active"><a href="#">{$aLang.block_stream_comments}</a></li>
		<li id="block_stream_item_topic"><a href="#">{$aLang.block_stream_topics}</a></li>
		
		{hook run='block_stream_nav_item'}
	</ul>					
	
	
	<div class="block-content" id="block_stream_content">
		{$sStreamComments}
	</div>
</section>

