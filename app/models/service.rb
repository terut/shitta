class Service < ActiveRecord::Base
  def save_with_api(username, password)
    qiita = Qiita.new url_name: username,
                      password: password

    self.attributes = { username: qiita.url_name, token: qiita.token }
    self.save
  rescue
    # TODO bad request exception
    return false
  end
end
