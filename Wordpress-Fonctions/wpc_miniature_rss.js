function wpc_rss_miniature($excerpt) {
global $post;

$content = '<p>' . get_the_post_thumbnail($post->ID) .
'</p>' . get_the_excerpt();

return $content;
}
add_filter('the_excerpt_rss', 'wpc_rss_miniature');
add_filter('the_content_feed', 'wpc_rss_miniature');
