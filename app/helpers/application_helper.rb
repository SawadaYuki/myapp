module ApplicationHelper
  def menu_link_to(text, path)
    link_to_unless_current(text, path) { content_tag(:span, text) }
  end

  def story_humantype_image1(story,options={})
  	if story.humantype1.present?
  	   path=story_path(story,format: story.humantype1)
  	   link_to(image_tag(path,size: "50x50"),path)
  	else
  		""
  	end
  end

  def story_humantype_image2(story,options={})
  	if story.humantype2.present?
  	   path=story_path(story,format: story.humantype2)
  	   link_to(image_tag(path,size: "50x50"),path)
  	else
  		""
  	end
  end

end

# image_tag(画像のファイルパス,alt:省略時はファイル名から拡張子をのぞいたものを自動的にセット)
# link_to ('リンクテキスト',リンク先のパス)
