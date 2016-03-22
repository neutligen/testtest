module ApplicationHelper

  # ページのタイトルがなければ、デフォルトタイトルを表示する
  def full_title(page_title = '')
	  base_title = "Habitize"
	  if page_title.empty?
		  base_title
	  else
		  base_title + " | " + page_title
	  end
  end

end