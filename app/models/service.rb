class Service < ActiveRecord::Base
  def save_with_api(username, password)
    qiita = Qiita.new url_name: username,
                      password: password

    self.assign_attributes({ username: qiita.url_name, token: qiita.token },
                           without_protection: true)
    self.save
  #rescue
  #  return false
  end
end
