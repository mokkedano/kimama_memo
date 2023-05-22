class Public::HomesController < ApplicationController


  def top
    @posts = Post.all.order('id DESC').limit(6)
  end


  def about
  end

end
