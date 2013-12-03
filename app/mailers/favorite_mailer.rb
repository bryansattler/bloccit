class FavoriteMailer < ActionMailer::Base
  default from: "bsattler@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@bryansattler-bloccit>"
    headers["In-Reply-To"] = "<post/#{@post.id}@bryansattler-bloccit>"
    headers["References"] = "<post/#{@post.id}@bryansattler-bloccit>"

    mail(to: user.email, subject: "New comment on #{post.title}")

  end  

end
